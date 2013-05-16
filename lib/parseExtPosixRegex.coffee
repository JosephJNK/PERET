_ = require 'underscore'

repetitionCharacters = '?.*+'.split ''

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
  _.last(results).type = 'repeated literal'
  null
