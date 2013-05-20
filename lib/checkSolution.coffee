extUnixToJs = require './extPosixToJs.coffee'

module.exports = (problem, solutionAttempt, actualSolution) ->
  jsSolutionAttempt = extUnixToJs solutionAttempt
  jsActualSolution = extUnixToJs actualSolution

  error = false
  for item in problem.hits.concat problem.misses
    error = error or (jsSolutionAttempt.test(item) isnt jsActualSolution.test item)

  not error
