generateItem = (item) ->
  results = ''
  if item.type? and item.type is 'literal'
    results = results + item.value
    results = results + generateRepetitionCharacter item.repetition if item.repetition?
  else if item.type? and item.type is 'character class'
    results = results + generateCharacterClass item
    results = results + generateRepetitionCharacter item.repetition if item.repetition?
  else if item.concatenation?
    results = generateConcatenation item.concatenation
  else if item.alternation?
    results = generateAlternation item.alternation
  else
    throw "Error generating regex: invalid input:" + item
  results

generateConcatenation = (concatenationArray) ->
  results = ""
  for item in concatenationArray
    results = results + generateItem item
  results

generateAlternation = (alternationArray) ->
  results = generateItem alternationArray[0]
  for item in alternationArray.slice 1
    results = results + '|' + generateItem item
  results

generateCharacterClass = (classItem) ->
  throw 'not implemented'

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

module.exports = generateItem
