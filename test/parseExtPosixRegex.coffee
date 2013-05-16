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

  it 'should specify 0 to one repetition when ? is used', ->
    testString = 'a?'

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 1
    results[0].type.should.eql 'repeated literal'
    results[0].value.should.eql 'a'
    results[0].repetitionMin.should.eql 0
    results[0].repetitionMax.should.eql 1

  it 'should specify 0 to Infinity repetitions when * is used', ->
    testString = 'a*'

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 1
    results[0].type.should.eql 'repeated literal'
    results[0].value.should.eql 'a'
    results[0].repetitionMin.should.eql 0
    results[0].repetitionMax.should.eql Infinity

  it 'should specify 0 to Infinity repetitions when + is used', ->
    testString = 'a+'

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 1
    results[0].type.should.eql 'repeated literal'
    results[0].value.should.eql 'a'
    results[0].repetitionMin.should.eql 1
    results[0].repetitionMax.should.eql Infinity

  it 'should specify a range when {} is used', ->
    testString = 'a{1,200}'

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 1
    results[0].type.should.eql 'repeated literal'
    results[0].value.should.eql 'a'
    results[0].repetitionMin.should.eql 1
    results[0].repetitionMax.should.eql 200

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
    results[0].type.should.eql 'repeated literal'
    results[0].value.should.eql 'a'
    results[0].repetitionMin.should.eql 1
    results[0].repetitionMax.should.eql Infinity

  it 'should handle using {} with only minimum argument', ->
    testString = 'a{,2}'

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 1
    results[0].type.should.eql 'repeated literal'
    results[0].value.should.eql 'a'
    results[0].repetitionMin.should.eql 0
    results[0].repetitionMax.should.eql 2

  it 'should handle {} with exact count', ->
    testString = 'a{2}'

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 1
    results[0].type.should.eql 'repeated literal'
    results[0].value.should.eql 'a'
    results[0].repetitionMin.should.eql 2
    results[0].repetitionMax.should.eql 2


