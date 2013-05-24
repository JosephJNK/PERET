_ = require 'underscore'

walkNode = (node, index) ->
  steps = []
  return [stepifyStandaloneNode(node), index, 1] unless node.alternation? or node.concatenation?

  if node.alternation?
    currentIndex = index
    totalConsumed = 1
    combinedIndices = []
    subNodes = node.alternation.length
    for subNode in node.alternation
      [subSteps, subIndex, nodesConsumed] = walkNode subNode, currentIndex
      combinedIndices.push subIndex
      currentIndex += nodesConsumed
      totalConsumed += nodesConsumed
      steps.push subSteps
    steps.push stepifyAlternationNode node, combinedIndices, steps
    return [steps, currentIndex, totalConsumed]

  throw "TILT: non-standalone non-alternation node encountered while stepifying problem"

stepifyAlternationNode = (node, combinedIndices, currentSteps) ->
  stepList = stepListFromIndices combinedIndices
  combinationSolution = combineAlternateIndices combinedIndices, currentSteps
  {
    statement: "Combine the results of #{stepList} using alternation"
    solution: combinationSolution
  }

combineAlternateIndices = (indices, steps) ->
  solutions = []
  for index in indices
    solutions.push steps[index - 1].solution
  solutions.join '|'

stepListFromIndices = (indices) ->
  return "step #{indices[0]} and step #{indices[1]}" if indices.length is 2
  [leading..., last] = indices
  string = ""
  for index in leading
    string = string + "step #{indices[index]}, "

  string + "and step #{indices[last]}"

stepifyStandaloneNode = (node) ->
  {
    statement: "Write a regex that selects lines #{node.statement}"
    solution: node.solution
  }

module.exports = (problem) ->
  results = [stepifyStandaloneNode problem]
  [steps, junk...] = walkNode problem, 1

  results = results.concat steps if steps.length > 1

  {
    testValues: _.shuffle problem.hits.concat problem.misses
    steps: results
  }

