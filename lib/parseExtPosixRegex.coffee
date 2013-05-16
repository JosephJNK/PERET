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
    error = "#{string[0]} must follow a character literal."
  else
    [error, parsedElement, charactersConsumed] = parseLiteral string

  [error, parsedElement, charactersConsumed]

parseLiteral = (string) ->
  error = null
  if string.length is 1
    consumed = 1
    parsedElement = encodeLiteral string[0]
  else if _.contains repetitionCharacters, string[1]
    [error, parsedElement, consumed] = parseRepetition string
  else
    consumed = 1
    parsedElement = encodeLiteral string[0]

  [error, parsedElement, consumed]

parseRepetition = ([character, repetition, rest...]) ->
  error = null
  if repetition is '?'
    min = 0
    max = 1
    consumed = 2
  else if repetition is '+'
    min = 1
    max = Infinity
    consumed = 2
  else if repetition is '*'
    min = 0
    max = Infinity
    consumed = 2
  else if repetition is '{'
    [error, min, max, consumed] = parseCurlyBraceContents rest
    consumed += 2 #include the character and opening brace
    return [error, null, 0] if error
  else
    throw 'TILT: invalid repetition character'

  parsed = {
    type: 'repeated literal'
    value: character
    repetitionMin: min
    repetitionMax: max
  }

  [null, parsed, consumed]

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
