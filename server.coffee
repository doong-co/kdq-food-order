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
        console.log "abc"

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
      spreadsheetName: "abc"
      worksheetName: "Sheet1"
      accessToken:
        type: "Bearer"
        token: "AIzaSyB-CtsNplWBP4IE8dzdG_ncwaNL_iAAAEY"
    , loadSuccess