express = require 'express'
{join} = require 'path'
http = require 'http'
coffeescript = require 'connect-coffee-script'
stylus = require 'stylus'
nib = require 'nib'

app = express()

compile = (str, path) ->
  stylus(str).set('force', true).set('filename', path).set('compress', false).use( nib() ).import('nib')

app.use coffeescript src: join(__dirname, "/public"), bare: true
app.use stylus.middleware src: join(__dirname, "/public"), compile: compile
app.set 'views', join __dirname, '/views'
app.set 'view options', { pretty: true, layout: false }
app.set 'view engine', 'jade'
app.use express.static join __dirname, '/public'

app.get '/', (req, res) ->
  res.render 'tutor',
    title: 'Home'
    stepNumber: "5"

app.listen 8000
