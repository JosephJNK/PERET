
module.exports = (inputArray) ->
  results = ""
  for character in inputArray
    results = results + character.value

  return results
