getAllKCs = require './getAllKCs.coffee'

module.exports = (solution) ->
  kcs = getAllKCs()
  matchedKCs = []
  for kc in kcs
    matchedKCs.push kc if kc.solutionPattern.test solution

  matchedKCs
