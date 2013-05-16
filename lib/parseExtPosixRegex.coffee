_ = require 'underscore'

repetitionCharacters = '?*+'.split ''

module.exports = (inputString) ->
  results = []
  for character, i in inputString
    if _.contains repetitionCharacters, character
      error = applyRepetitionCharacter results, character
      return [{message: error}, null] if error
    else
      results.push {type: 'literal', value: character}

  [null, results]

applyRepetitionCharacter = (results, character) ->
  if results.length == 0 or _.last(results).type != 'literal'
    return "#{character} must follow a character literal."

  if character is '?'
    min = 0
    max = 1
  else if character is '+'
    min = 1
    max = Infinity
  else if character is '*'
    min = 0
    max = Infinity
  else
    throw 'TILT: invalid repeitition character'
  _.last(results).type = 'repeated literal'
  _.last(results).repetitionMin = min
  _.last(results).repetitionMax = max
  null
