express = require "express"

module.exports = (opts) ->

  app = express()

  app.use "/", express.static __dirname + "/app"
  
  app.listen opts.port

  app.post "/food", (rep, res) ->
    console.log rep.body
    res.send "OK"

