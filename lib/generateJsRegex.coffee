
module.exports = (inputArray) ->
  results = ""
  for character in inputArray
    if character.type is 'literal'
      results = results + character.value
    else if character.type is 'repeated literal'
      results = results + generateRepeatedCharacter character
    else
      throw "Error generating regex: character '#{character.value}' has invalid type: '#{character.type}'"

  return results

generateRepeatedCharacter = (character) ->
  unless character.repetitionMin? and character.repetitionMax?
    throw 'Error generating regex: repeated character lacks bounds: ' + characer

  if character.repetitionMin is 0 and character.repetitionMax is Infinity
    return "#{character.value}*"
  else if character.repetitionMin is 0 and character.repetitionMax is 1
    return "#{character.value}?"
  else if character.repetitionMin is 1 and character.repetitionMax is Infinity
    return "#{character.value}+"
  else
    throw "Error generating regex: '#{character.value}' has invalid range '#{character.repetitionMin}' - '#{character.repetitionMax}'"
