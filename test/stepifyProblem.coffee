should = require 'should'

stepifyProblem = require '../lib/stepifyProblem.coffee'
problem1 = require '../problems/problem1.coffee'
problem2 = require '../problems/problem2.coffee'

describe 'Stepify Problem', ->

  it 'should flatten problem into series of step objects', ->
    stepified = stepifyProblem problem2

    testValues = problem2.hits.concat problem2.misses
    stepified.testValues.should.includeEql for value in testValues

    stepified.steps[0].statement.should.eql "Write a regex that selects lines containing the string 'ab' or 'ib'"
    stepified.steps[0].solution.should.eql 'ab|ib'

    stepified.steps[1].statement.should.eql "Write a regex that selects lines containing the string 'ab'"
    stepified.steps[1].solution.should.eql 'ab'

    stepified.steps[2].statement.should.eql "Write a regex that selects lines containing the string 'ib'"
    stepified.steps[2].solution.should.eql 'ib'

    stepified.steps[3].statement.should.eql "Combine the results of step 1 and step 2 using alternation"
    stepified.steps[3].solution.should.eql 'ab|ib'

  it 'should handle already flat problems', ->
    stepified = stepifyProblem problem1

    testValues = problem1.hits.concat problem1.misses
    stepified.testValues.should.includeEql for value in testValues

    stepified.steps.length.should.eql 1
    stepified.steps[0].statement.should.eql "Write a regex that selects lines containing the string 'a'"
    stepified.steps[0].solution.should.eql 'a'
