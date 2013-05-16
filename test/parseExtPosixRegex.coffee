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

  it 'should handle question mark, dot and star', ->
    testString = 'a?b.c*d'
    expectedTypes = [
      'repeated literal'
      'repeated literal'
      'repeated literal'
      'literal'
    ]
    expectedValues = 'abcd'


    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 4
    for i in [0...4]
      results[i].type.should.eql expectedTypes[i]
      results[i].value.should.eql expectedValues[i]

  it 'should return an error when *, + and ? are used without targets', ->
    for char in '*+?'
      [error, results] = parseRegex char
      should.not.exist results

      error.should.eql {message: "#{char} must follow a character literal."}

