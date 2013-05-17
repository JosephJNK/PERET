{readdirSync} = require 'fs'

filenames = readdirSync './KCs'
kcs = []
kcs.push require "../KCs/" + file for file in filenames

module.exports = ->
  kcs
