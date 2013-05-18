should = require 'should'
generateJsRegex = require '../lib/generateJsRegex.coffee'

describe 'Generate JS Regex', ->

  it 'should generate string from non-grouping characters', ->
    input = [
      {
        value: 'a'
        type: 'literal'
      }
      {
        value: 'b'
        type: 'literal'
      }
    ]

    output = generateJsRegex input

    output.should.eql 'ab'

  it 'should insert a star when an element can be repeated 0-Infinity times', ->
    input = [
      {
        value: 'a'
        type: 'literal'
        repetition:
          minimum: 0
          maximum: Infinity
      }
      {
        value: 'b'
        type: 'literal'
      }
    ]

    output = generateJsRegex input

    output.should.eql 'a*b'

  it 'should generate repetition meta-characters when an element can be repeated 0-1 or 1-Infinity times', ->
    input = [
      {
        value: 'a'
        type: 'literal'
        repetition:
          minimum: 0
          maximum: 1
      }
      {
        value: 'b'
        type: 'literal'
        repetition:
          minimum: 1
          maximum: Infinity
      }
    ]

    output = generateJsRegex input

    output.should.eql 'a?b+'

  it 'should generate curly braces for arbitrary repetition', ->
    input = [
      {
        value: 'a'
        type: 'literal'
        repetition:
          minimum: 1
          maximum: 30
      }
      {
        value: 'b'
        type: 'literal'
        repetition:
          minimum: 0
          maximum: 3
      }
      {
        value: 'c'
        type: 'literal'
        repetition:
          minimum: 100
          maximum: Infinity
      }
      {
        value: 'd'
        type: 'literal'
        repetition:
          minimum: 5
          maximum: 5
      }
    ]

    output = generateJsRegex input

    output.should.eql 'a{1,30}b{0,3}c{100,}d{5}'

