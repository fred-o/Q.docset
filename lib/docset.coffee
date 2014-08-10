cheerio  = require 'cheerio'
fs       = require 'fs'
path     = require 'path'
sqlite3  = require 'sqlite3'
Document = require './document'

module.exports = class Docset
    constructor: ->
        @index  = new sqlite3.Database './Contents/Resources/docSet.dsidx'
        console.log "Dropping existing index..."
        @index.exec "DELETE FROM searchIndex;"

    parse: (fileName) ->
        console.log "Parsing #{fileName}..."
        doc = new Document path.basename(fileName), @index
        $ = cheerio.load fs.readFileSync fileName

        $('a.anchor').each (i, el) ->
            el = cheerio(el)
            name = el.parent().text().trim()
            anchor = el.attr('name')
            type = 'Entry'
            if name.match /.*\..*\(.*\)/
                type = 'Function'
            if name.match /Q[\.\(].*/
                type = 'Function'
            doc.add name, type, anchor
            

