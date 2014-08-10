sqlite3  = require 'sqlite3'
Document = require './document'

module.exports = class Docset
    constructor: ->
        @index  = new sqlite3.Database './Contents/Resources/docSet.dsidx'
        @index.exec "DELETE FROM searchIndex;"

    document: (fileName) ->
        new Document fileName, @index
    
