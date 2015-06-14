express = require "express"

module.exports = (opts) ->

  app = express()

  app.use "/", express.static __dirname + "/app"
  
  app.listen opts.port

  app.post "/food", (req, res) ->
    console.log req.params
    console.log req.body
    console.log req.header
    
    token = req.params.token
    if token isnt "Nu7nYM6V2Izg26blK8Gi3EYW"
      return res.send "ERROR"

    console.log req.params
    res.send req.params