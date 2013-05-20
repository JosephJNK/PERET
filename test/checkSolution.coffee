should = require 'should'

problem1 = require '../problems/problem1.coffee'
checkSolution = require '../lib/checkSolution.coffee'

describe 'Check Solution', ->
  it 'should return true if a solution is correct', ->
    solutionAttempt = problem1.solution
    actualSolution = problem1.solution

    wasCorrect = checkSolution problem1, solutionAttempt, actualSolution

    wasCorrect.should.eql true
