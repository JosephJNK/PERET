_ = require 'underscore'

walkNode = (problemNode, index) ->
  return [stepifyStandaloneNode(problemNode), index] unless node.alternation? or node.concatenation?

  if node.alternation?
    subNodes = node.alternation.length


stepifyStandaloneNode = (node) ->
  {
    statement: "Write a regex that selects lines #{node.statement}"
    solution: node.solution
  }

module.exports = (problem) ->

  testValues = _.shuffle problem.hits.concat problem.misses
  steps = []

  steps[0] = stepifyStandaloneNode problem

  

  steps
