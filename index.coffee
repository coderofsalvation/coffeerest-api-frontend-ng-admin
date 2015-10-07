clone      = (obj) -> JSON.parse JSON.stringify obj
mustache   = require 'mustache'
jsfront    = require('jsonschema-frontend')
 
module.exports = (server, model, lib, urlprefix ) ->

  me = @

  @.init =  (uimodel) ->
    @.uimodel = uimodel = jsfront.parse uimodel
    console.log JSON.stringify uimodel, null, 2
    uimodel.js   = require('fs').readFileSync(__dirname+"/node_modules/ng-admin/build/ng-admin.min.js").toString()
    jscode = []
    jscode.push "var admin = nga.application('"+uimodel.menu.title+"')"
    jscode.push "  .baseApiUrl('"+uimodel.model.host+"');"
    jscode.push "var entity = {};"
    for k,resource of uimodel.resources
      slug = k.split "/"
      jscode.push "entity."+ slug[1] + " = nga.entity('"+ slug[1] + "');"
    for menuitem in uimodel.menu.items
      jsfront.render "menuitem.js", menuitem, jscode
    jscode[k] = "        "+v for k,v of jscode
    uimodel.jsconfig = jscode.join("\n") + ";\n"
    uimodel.css  = require('fs').readFileSync(__dirname+"/node_modules/ng-admin/build/ng-admin.min.css").toString()
    uimodel.html = require('fs').readFileSync(__dirname+"/src/mustache/index.html").toString()

  @.generateHTML = () ->
    return mustache.render @.uimodel.html, @.uimodel 

  lib.events.on 'beforeStart', (data, next) ->
    me.init lib.uimodel 
    server = data.server 
    model  = data.model 
    lib    = data.lib 
    urlprefix = data.urlprefix 

    # register html url
    console.log "registering REST resource: /admin"
    ( (urlprefix,model,me) ->
        server.get "/admin", (req,res,next) ->
            body = me.generateHTML()
            res.writeHead 200, 
              'Content-Length': Buffer.byteLength(body),
              'Content-Type': 'text/html'
            res.write(body)
            res.end()
            next()
    )(urlprefix,model,me)

    next()

  return me
