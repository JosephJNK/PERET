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
        type: 'repeated literal'
        repetitionMin: 0
        repetitionMax: Infinity
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
        type: 'repeated literal'
        repetitionMin: 0
        repetitionMax: 1
      }
      {
        value: 'b'
        type: 'repeated literal'
        repetitionMin: 1
        repetitionMax: Infinity
      }
    ]

    output = generateJsRegex input

    output.should.eql 'a?b+'

  it 'should generate curly braces for arbitrary repetition', ->
    input = [
      {
        value: 'a'
        type: 'repeated literal'
        repetitionMin: 1
        repetitionMax: 30
      }
      {
        value: 'b'
        type: 'repeated literal'
        repetitionMin: 0
        repetitionMax: 3
      }
      {
        value: 'c'
        type: 'repeated literal'
        repetitionMin: 100
        repetitionMax: Infinity
      }
      {
        value: 'd'
        type: 'repeated literal'
        repetitionMin: 5
        repetitionMax: 5
      }
    ]

    output = generateJsRegex input

    output.should.eql 'a{1,30}b{0,3}c{100,}d{5}'

