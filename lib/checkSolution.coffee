extUnixToJs = require './extPosixToJs.coffee'

module.exports = (problem, solutionAttempt, actualSolution) ->
  [error, jsSolutionAttempt] = extUnixToJs solutionAttempt
  [error, jsActualSolution] = extUnixToJs actualSolution

  hits = []
  falseHits = []
  misses = []

  for item in problem.hits.concat problem.misses
    shouldInclude = jsActualSolution.test item
    didInclude = jsSolutionAttempt.test item

    if shouldInclude and not didInclude
      misses.push item
    else if (not shouldInclude) and didInclude
      falseHits.push item
    else if shouldInclude and didInclude
      hits.push item

  {
    hits: hits
    falseHits: falseHits
    misses: misses
    correct: falseHits.length is 0 and misses.length is 0
  }
