express = require 'express'
stylus = require 'stylus'
app = express()

compile = (str, path) ->
  stylus(str).set('filename', path)

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use stylus.middleware { src: __dirname + '/public', compile: compile }
app.use express.static __dirname + '/public'

app.get '/', (req, res) ->
  res.render 'tutor', title: 'Home'

app.listen 8000
