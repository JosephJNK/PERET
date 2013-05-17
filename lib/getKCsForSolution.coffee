kc1 = require '../KCs/kc1.coffee'
kc2 = require '../KCs/kc2.coffee'
getAllKCs = -> [kc1, kc2]

module.exports = (solution) ->
  kcs = getAllKCs()
  matchedKCs = []
  for kc in kcs
    matchedKCs.push kc if new RegExp(kc.solutionPattern).test solution

  matchedKCs
