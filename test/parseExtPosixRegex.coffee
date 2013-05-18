should = require 'should'
parseRegex = require '../lib/parseExtPosixRegex.coffee'

describe 'Regex parser', ->
  it 'should parse alphanumeric characters to an array', ->
    testString = 'asdf'

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 4

    for i in [0..3]
      results[i].type.should.eql 'literal'
      results[i].value.should.eql testString[i]

  it 'should handle question mark, plus and star', ->
    testString = 'a?b+c*d'
    expectedValues = 'abcd'
    expectedRepetitions = [
      {minimum: 0, maximum: 1 }
      {minimum: 1, maximum: Infinity }
      {minimum: 0, maximum: Infinity }
      null
    ]

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 4
    for i in [0...4]
      results[i].type.should.eql 'literal'
      results[i].value.should.eql expectedValues[i]
      if expectedRepetitions[i]?
        expectedRepetitions[i].minimum.should.eql results[i].repetition.minimum
        expectedRepetitions[i].maximum.should.eql results[i].repetition.maximum

      should.not.exist results.repetition unless expectedRepetitions[i]?

  it 'should return an error when *, + and ? are used without targets', ->
    for char in '*+?'
      [error, results] = parseRegex char
      should.not.exist results

      error.should.eql {message: "#{char} must follow a literal or character class."}

  it 'should specify a range when {} is used', ->
    testString = 'a{1,200}'

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 1
    results[0].type.should.eql 'literal'
    results[0].value.should.eql 'a'
    results[0].repetition.minimum.should.eql 1
    results[0].repetition.maximum.should.eql 200

  it 'should throw an error when { is used without }', ->
    testString = 'a{1,200'
    [error, results] = parseRegex testString
    should.not.exist results

    error.message.should.eql 'invalid curly brace syntax'

  it 'should handle using {} with only minimum argument', ->
    testString = 'a{1,}'

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 1
    results[0].type.should.eql 'literal'
    results[0].value.should.eql 'a'
    results[0].repetition.minimum.should.eql 1
    results[0].repetition.maximum.should.eql Infinity

  it 'should handle using {} with only maximum argument', ->
    testString = 'a{,2}'

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 1
    results[0].type.should.eql 'literal'
    results[0].value.should.eql 'a'
    results[0].repetition.minimum.should.eql 0
    results[0].repetition.maximum.should.eql 2

  it 'should handle {} with exact count', ->
    testString = 'a{2}'

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 1
    results[0].type.should.eql 'literal'
    results[0].value.should.eql 'a'
    results[0].repetition.minimum.should.eql 2
    results[0].repetition.maximum.should.eql 2

  it 'should handle []', ->
    testString = '[asdf]g'

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 2
    results[0].type.should.eql 'character class'
    results[0].inverted.should.eql false
    {contents} = results[0]
    contents[0].type.should.eql 'literal'
    contents[0].value.should.eql 'a'
    contents[1].type.should.eql 'literal'
    contents[1].value.should.eql 's'
    contents[2].type.should.eql 'literal'
    contents[2].value.should.eql 'd'
    contents[3].type.should.eql 'literal'
    contents[3].value.should.eql 'f'

    results[1].type.should.eql 'literal'
    results[1].value.should.eql 'g'

  it 'should return an error if square brackets are not closed', ->
    testString = '[asdf'

    [error, results] = parseRegex testString
    should.not.exist results

    error.should.eql {message: "Unclosed character class"}

  it 'should handle a repeated character class', ->
    testString = '[ab]*c'

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 2
    results[0].type.should.eql 'character class'
    results[0].inverted.should.eql false
    results[0].repetition.minimum.should.eql 0
    results[0].repetition.maximum.should.eql Infinity
    {contents} = results[0]
    contents[0].type.should.eql 'literal'
    contents[0].value.should.eql 'a'
    contents[1].type.should.eql 'literal'
    contents[1].value.should.eql 'b'

    results[1].type.should.eql 'literal'
    results[1].value.should.eql 'c'
