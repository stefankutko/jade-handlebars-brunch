jade = require 'jade'
handlebars = require 'handlebars'
sysPath = require 'path'

module.exports = class JadeHandlebarsCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'jhbs'
  pattern: /\.(?:jhbs|jhandlebars)$/

  constructor: (@config) ->
    null

  compile: (data, path, callback) ->
    try
      jadeOutput = jade.compile data,
        compileDebug: no
        filename: path

      content = handlebars.precompile jadeOutput()
      result = "module.exports = Handlebars.template(#{content});"
    catch err
      error = err
    finally
      callback error, result

  include: [
    (sysPath.join __dirname, '..', 'node_modules', "handlebars", "dist",
      'handlebars.runtime.js')
  ]
