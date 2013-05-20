parse = require './parseExtPosixRegex.coffee'
generate = require './generateJsRegex.coffee'

module.exports = (inputString) ->
  [error, intermediateForm] = parse inputString
  return error if error

  resultantForm = generate intermediateForm

  new RegExp resultantForm
