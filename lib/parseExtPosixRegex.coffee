_ = require 'underscore'

repetitionCharacters = '?*+{'.split ''

module.exports = (inputString) ->
  results = []
  charactersConsumed = 0

  while charactersConsumed < inputString.length
    [error, parsedElement, stepConsumed] = parseCharacter inputString.slice charactersConsumed
    return [{message: error}, null] if error
    results.push parsedElement
    charactersConsumed += stepConsumed

  [null, results]

parseCharacter = (string) ->
  error = null
  parsedElement = null
  charactersConsumed = 0

  if _.contains repetitionCharacters, string[0]
    error = "#{string[0]} must follow a literal or character class."
  else if string[0] is '['
    [error, parsedElement, charactersConsumed] = parseCharacterClass string
  else
    [error, parsedElement, charactersConsumed] = parseLiteral string

  [error, parsedElement, charactersConsumed]

parseCharacterClass = (string) ->
  error = null
  endBraceIndex = string.indexOf ']'
  return ["Unclosed character class", null, 0] if endBraceIndex < 0
  classContents = string.slice 1, endBraceIndex

  results =
    type: 'character class'
    inverted: false
    contents: []

  for character in classContents.split ''
    results.contents.push encodeClassCharacter character

  consumed = endBraceIndex + 1

  if string.length > endBraceIndex and _.contains repetitionCharacters, string[endBraceIndex + 1]
    [error, results.repetition, repetitionConsumed] = parseRepetition string.slice endBraceIndex + 1
    consumed += repetitionConsumed

  [error, results, consumed]

parseLiteral = (string) ->
  error = null
  parsedElement = encodeLiteral string[0]
  consumed = 1
  if _.contains repetitionCharacters, string[1]
    [error, repetition, repetitionConsumed] = parseRepetition string.slice 1
    consumed += repetitionConsumed
    parsedElement.repetition = repetition

  [error, parsedElement, consumed]

parseRepetition = ([repetition, rest...]) ->
  error = null
  if repetition is '?'
    min = 0
    max = 1
    consumed = 1
  else if repetition is '+'
    min = 1
    max = Infinity
    consumed = 1
  else if repetition is '*'
    min = 0
    max = Infinity
    consumed = 1
  else if repetition is '{'
    [error, min, max, consumed] = parseCurlyBraceContents rest
    consumed += 1 #include the opening brace
    return [error, null, 0] if error
  else
    throw 'TILT: invalid repetition character'

  repetition = {
    minimum: min
    maximum: max
  }

  [null, repetition, consumed]

parseCurlyBraceContents = (contents) ->
  results = /^(\d*),?(\d*)}/.exec contents.join('')
  return ["invalid curly brace syntax", 0, 0, 0] unless results?
  [totalMatch, min, max] = results
  if _.contains totalMatch, ','
    min = if min is '' then 0 else parseInt min
    max = if max is '' then Infinity else parseInt max
  else
    min = parseInt(min)
    max = min

  [null, min, max, totalMatch.length]

encodeLiteral = (character) ->
  {
    type: 'literal'
    value: character[0]
  }

encodeClassCharacter = (character) ->
  {
    type: 'literal'
    value: character
  }
