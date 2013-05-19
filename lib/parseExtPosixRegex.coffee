_ = require 'underscore'

repetitionCharacters = '?*+{'.split ''

parse = (inputString) ->
  if containsAlternation inputString
    parseAlternation inputString
  else
    parseConcatenation inputString

walkSeparators = (inputString, fn) ->
  #executes fn on every element in inputString with a flag indicating whether we're inside separators or escape sequences
  #returns immediately if fn returns false

  #TODO: this won't quite work... needs tweaking to handle ']' directly following '['
        #Hooray for function scope flags!
  stack = []

  shouldContinue = true
  callFn = (char, escaped) ->
    escaped = true if stack.length > 0
    shouldContinue = shouldContinue and fn char, 0

  checkCharacter = (index) ->
    shouldPop = false
    push = ''
    charsChecked = 1

    if inputString[index] is '\\'
      if stack.length > 0 and _.last(stack) is '['
        callFn inputString[index], true
      else
        callFn inputString[index], false
        callFn inputString[index + 1], true if shouldContinue
        charsChecked = 2
    else if inputString[index] is '('
      callFn inputString[index], false
      push = '('
    else if inputString[index] is '['
      callFn inputString[index], false
      push = '['
    else if inputString[index] is ')'
      shouldPop = true if _.last(stack) is '('
      callFn inputString[index], false
    else if inputString[index] is ']'
      shouldPop = true if _.last(stack) is '['
      callFn inputString[index], false
    else
      callFn inputString[index], false

    [charsChecked, shouldPop, push]

  i = 0
  while i < inputString.length
    [consumed, pop, push] = checkCharacter i
    i += consumed
    stack.pop() if pop
    stack.push push if push isnt ''
    return unless shouldContinue

containsAlternation = (inputString) ->
  pipeFound = false
  isUnescapedPipe = (char, isEscaped) ->
    if (char is '|') and not isEscaped
      pipeFound = true 
      return false
    true

  walkSeparators inputString, isUnescapedPipe
  pipeFound

splitAlongAlternation = (inputString) ->
  results = ['']
  segmentsFound = 0

  pushToResults = (char, isEscaped) ->
    if (char is '|') and not isEscaped
      segmentsFound++
      results[segmentsFound] = ''
    else
      results[segmentsFound] = results[segmentsFound] + char
    true

  walkSeparators inputString, pushToResults
  results

parseConcatenation = (inputString) ->
  results = concatenation: []
  charactersConsumed = 0

  while charactersConsumed < inputString.length
    [error, parsedElement, stepConsumed] = parseCharacter inputString.slice charactersConsumed
    return [{message: error}, null] if error
    results.concatenation.push parsedElement
    charactersConsumed += stepConsumed

  [null, results]

parseAlternation = (inputString) ->
  alternates = splitAlongAlternation inputString
  results = alternation: []

  for alternate in alternates
    [error, parsedAlternate] = parse alternate
    return [error, null] if error
    results.alternation.push parsedAlternate

  return [null, results]

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

module.exports = parse
