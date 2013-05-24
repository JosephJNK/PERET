loaded =
  #checkSolution: require './checkSolution.coffee'
  generateJsRegex: require './generateJsRegex.coffee'
  #getKCsForProblem: require './getKCsForProblem.coffee'
  parseExtPosixRegex: require './parseExtPosixRegex.coffee'
  extPosixToJs: require './extPosixToJs.coffee'
  stepifyProblem: require './stepifyProblem.coffee'
  #getAllKCs: require './getAllKCs.coffee'
  #getKCsForSolution: require './getKCsForSolution.coffee'

window.lib = loaded if window?
module.exports = loaded
