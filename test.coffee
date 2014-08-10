cheerio = require 'cheerio'
fs      = require 'fs'
Docset  = require './lib/docset'

api = cheerio.load fs.readFileSync 'Contents/Resources/Documents/api.html'

docset = new Docset
doc = docset.document 'api.html'

api('a.anchor').each (i, el) ->
    el = cheerio(el)

    name = el.parent().text().trim()
    anchor = el.attr('name')
    type = 'Entry'    
    if name.match /.*\..*\(.*\)/ or name.match /^Q[\.(].*/
        type = 'Function'

    doc.add name, type, anchor


