should = require 'should'
parseRegex = require '../lib/parseExtPosixRegex.coffee'

describe "Regex parser", ->
  it "should parse alphanumeric characters to an array", ->
    testString = "asdf"

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql 4

    for i in [0..3]
      results[i].type.should.eql "character"
      results[i].value.should.eql testString[i]

  it "should handle question mark, dot and star", ->
    testString = "a?b.c*d"
    desiredTypes = [
      "character"
      "metacharacter"
      "character"
      "metacharacter"
      "character"
      "metacharacter"
      "character"
    ]

    [error, results] = parseRegex testString
    should.not.exist error

    results.length.should.eql testString.length
    for i in [0...testString.length]
      results[i].type.should.eql desiredTypes[i]
      results[i].value.should.eql testString[i]

