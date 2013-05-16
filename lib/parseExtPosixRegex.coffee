_ = require 'underscore'

repetitionCharacters = '?*+'.split ''

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
  else
    throw 'TILT: invalid repetition character'

  parsed = {
    type: 'repeated literal'
    value: character
    repetitionMin: min
    repetitionMax: max
  }

  [null, parsed, consumed]

encodeLiteral = (character) ->
  {
    type: 'literal'
    value: character[0]
  }
