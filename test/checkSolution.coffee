should = require 'should'

problem1 = require '../problems/problem1.coffee'
checkSolution = require '../lib/checkSolution.coffee'
stepifyProblem = require '../lib/stepifyProblem.coffee'

describe 'Check Solution', ->
  it 'should return correct if a solution is correct', ->
    solutionAttempt = problem1.solution
    actualSolution = problem1.solution

    problem = stepifyProblem problem1

    results = checkSolution problem.testValues, solutionAttempt, actualSolution

    results.correct.should.eql true

    results.falseHits.length.should.eql 0
    results.misses.length.should.eql 0

    results.hits.length.should.eql problem1.hits.length

    for hit in problem1.hits
      results.hits.should.includeEql hit

  it 'should return misses if a solution does not contain all targets', ->
    actualSolution = problem1.solution

    solutionAttempt = "(^#{problem1.hits[0]}$)"

    for hit in problem1.hits.slice 1, problem1.hits.length - 1
      solutionAttempt = solutionAttempt + "|(^#{hit}$)"

    console.log 'solutionAttempt: ' + solutionAttempt

    problem = stepifyProblem problem1

    results = checkSolution problem.testValues, solutionAttempt, actualSolution

    results.correct.should.eql false
    results.falseHits.length.should.eql 0
    results.misses.length.should.eql 1
    results.hits.length.should.eql problem1.hits.length - 1

    results.misses[0].should.eql problem1.hits[problem1.hits.length - 1]
