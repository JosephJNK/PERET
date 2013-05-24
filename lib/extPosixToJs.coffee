parse = require './parseExtPosixRegex.coffee'
generate = require './generateJsRegex.coffee'

module.exports = (inputString) ->
  [error, intermediateForm] = parse inputString
  return [error, null] if error

  resultantForm = generate intermediateForm

  [null, new RegExp resultantForm]
