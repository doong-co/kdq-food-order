express = require "express"
Spreadsheet = require "edit-google-spreadsheet"
_ = require "lodash"

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
      loadSheet "menu", (err, ss) ->
        return if err

        ss.receive (err, rows, info) ->
          return if err
          content = ""
          _.each rows, (row) ->
            content += row["1"] + ": " + row["2"] + "\n"

          return res.send content

    if command is ""
      return res.send "OK"

    if command.indexOf("order") > -1
      loadSheet "orders", (err, ss) ->
        return if err
        stt = command.split(" ")[1]

        ss.receive (err, rows, info) ->
          return if err
          len = _.size(rows) + 1
          console.log "abc", len
          ss.add { len: { 1: len, 2: stt } }
          ss.send (err) ->
            return if err
            res.send "OK"

    if command is "cancel"
      return res.send "OK"
    
    # console.log req.query
    # res.send "NOT SUPPORT"

  loadSheet = (sheetName, loadSuccess) ->
    Spreadsheet.load
      debug: true
      spreadsheetName: "kdq-food-orders"
      worksheetName: sheetName
      oauth:
        email: "174490504370-s80tnmbic7hl2cthccdke4e188j0790i@developer.gserviceaccount.com"
        keyFile: "google-oauth.pem"
    , loadSuccess