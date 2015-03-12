through = require "through"
ngAnnotate = require 'ng-annotate'

module.exports = (fileName) ->
  return through() unless /\.coffee$/i.test(fileName)
  inputString = ""
  through ((chunk) ->
    inputString += chunk
  ), ->
    try
      annotatedFile = ngAnnotate(inputString, {add: true})
    catch e
      @emit "error", e
      return
    @queue annotatedFile.src
    @queue null
