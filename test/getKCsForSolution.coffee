should = require 'should'

getKCsForSolution = require '../lib/getKCsForSolution.coffee'

describe 'Get KCs for solution', ->
  it 'should return KCs that were used in a solution attempt', ->
    solution = '123'
    kcs = getKCsForSolution solution

    index1Contained = false
    for kc in kcs
      index1Contained = true if kc.index is 1
      kc.index.should.not.eql 2

    index1Contained.should.eql true
