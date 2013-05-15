_ = require 'underscore'

metacharacters = "?.*".split ""

module.exports = (inputString) ->
  results = []
  for character in inputString
    type = if _.contains(metacharacters, character) then "metacharacter" else "character"

    results.push {type: type, value: character}

  [null, results]
