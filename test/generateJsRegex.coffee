should = require 'should'
generateJsRegex = require '../lib/generateJsRegex.coffee'

describe 'Generate JS Regex', ->

  it 'should generate string from non-grouping characters', ->
    input = [
      {value: 'a'}
      {value: '*'}
      {value: 'b'}
      {value: '?'}
    ]

    output = generateJsRegex input

    output.should.eql 'a*b?'
