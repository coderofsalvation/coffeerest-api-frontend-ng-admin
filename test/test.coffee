request = require 'request' 

schema_api = require './testdata/jsonschema_api.coffee'
schema_ui  = require './testdata/jsonschema_ui.coffee'

request 
  method: "post"
  url: "http://localhost:8080/v1/context/backend.ng-admin"
  json: true,
  headers: { "content-type": "application/json" }
  body: 
    schema_api: schema_api 
    schema_ui: schema_ui 
,(err,res,body) ->
  require('fs').writeFileSync __dirname+'/../test.html', body

