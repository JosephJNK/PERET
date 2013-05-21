parse = require './parseExtPosixRegex.coffee'
generate = require './generateJsRegex.coffee'

module.exports = (inputString) ->
  [error, intermediateForm] = parse inputString
  return [error, null] if error

  resultantForm = generate intermediateForm

  {inspect} = require 'util'
  console.log inspect intermediateForm, false, null

  console.log "resultantForm: #{resultantForm}"

  [null, new RegExp resultantForm]
