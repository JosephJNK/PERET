{writeFileSync, readdirSync} = require 'fs'
{join} = require 'path'

filenames = readdirSync join __dirname, '../problems'
problems = []
problems.push require join(__dirname, "../problems/", file) for file in filenames

stringified = "window.problems = " + JSON.stringify problems

writeFileSync join(__dirname, "../public/scripts/problems.js"), stringified
