express = require "express"

module.exports = (opts) ->

  app = express()

  app.use "/", express.static __dirname + "/app"
  
  app.listen opts.port

  app.post "/food", (req, res) ->
    token = req.body.token
    if token isnt "Nu7nYM6V2Izg26blK8Gi3EYW"
      return res.send "ERROR"
      
    console.log req.body
    res.send req.body