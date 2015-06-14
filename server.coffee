express = require "express"

module.exports = (opts) ->

  app = express()

  app.use "/", express.static __dirname + "/app"
  
  app.listen opts.port

  app.get "/food", (req, res) ->
    console.log req.query
    console.log req.body
    console.log req.header

    token = req.query.token
    if token isnt "Nu7nYM6V2Izg26blK8Gi3EYW"
      return res.send "ERROR"

    console.log req.query
    res.send req.query