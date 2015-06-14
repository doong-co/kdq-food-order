express = require "express"
Spreadsheet = require "edit-google-spreadsheet"

module.exports = (opts) ->

  app = express()

  app.use "/", express.static __dirname + "/app"
  
  app.listen opts.port

  app.get "/food", (req, res) ->
    token = req.query.token
    username = req.query.user_name
    command = req.query.text

    if token isnt "Nu7nYM6V2Izg26blK8Gi3EYW"
      return res.send "ERROR"

    if command is "menu"
      loadMenu (err, ss) ->
        return if err

        ss.receive (err, rows, info) ->
          return if err
          console.log("Found rows:", rows)

      return res.send "OK"

    if command is ""
      return res.send "OK"

    if command.indexOf("order") > -1
      return res.send "OK"

    if command is "cancel"
      return res.send "OK"
    
    console.log req.query
    res.send "NOT SUPPORT"

  loadMenu = (loadSuccess) ->
    Spreadsheet.load
      debug: true
      spreadsheetName: "kdq-food-orders"
      worksheetName: "menu"
      oauth:
        email: "174490504370-s80tnmbic7hl2cthccdke4e188j0790i@developer.gserviceaccount.com"
        keyFile: "google-oauth.pem"
    , loadSuccess