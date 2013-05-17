should = require 'should'

problem1 = require '../problems/problem1.coffee'
getKCsForProblem = require '../lib/getKCsForProblem'

describe 'Get KCs for problem', ->
  it 'should match kc2 to problem 1', ->
    kcs = getKCsForProblem problem1

    index1Contained = false
    index1Contained = true if kc.index is 1 for kc in kcs

    index1Contained.should.eql true

  it 'should not match kc1 to problem 1', ->
    kcs = getKCsForProblem problem1
    kc.index.should.not.eql 1 for kc in kcs

