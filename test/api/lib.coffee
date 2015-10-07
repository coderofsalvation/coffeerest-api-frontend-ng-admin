
browserify = require 'browserify'

o = {}

o.contexts = ["mobile.appjs","backend.ng-admin"]

o.generate = (contexttype) ->
  #context = require("./../contexts/"+contexttype)()
  #context.init()
  #context.generateHTML()
  return "hoi"

module.exports = o
