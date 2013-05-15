require 'should'
parseRegex = require '../lib/parseRegex.coffee'

describe "Regex parser", ->
  it "should parse alphanumeric characters to an array", ->
    testString = "asdf"

    results = parseRegex testString
    results.length.should.eql 4

    for i in [0..3]
      results[i].type.should.eql "character"
      results[i].value.should.eql testString[i]
