
module.exports = (inputArray) ->
  results = ""
  for character in inputArray
    if character.type is 'literal'
      results = results + character.value
    else
      throw "Error generating regex: character '#{character.value}' has invalid type: '#{character.type}'"

    results = results + generateRepetitionCharacter character.repetition if character.repetition?

  return results

generateRepetitionCharacter = ({minimum, maximum}) ->
  if minimum is Infinity
    rangeError()
  else if minimum is 0 and maximum is Infinity
    return "*"
  else if minimum is 0 and maximum is 1
    return "?"
  else if minimum is 1 and maximum is Infinity
    return "+"
  else if maximum is Infinity
    return "{#{minimum},}"
  else if minimum is maximum
    return "{#{minimum}}"
  else
    return "{#{minimum},#{maximum}}"

rangeError = ->
    throw "Error generating regex: invalid range"

