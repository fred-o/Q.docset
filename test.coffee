cheerio = require 'cheerio'
fs      = require 'fs'
sqlite3 = require 'sqlite3'

api = cheerio.load fs.readFileSync 'Contents/Resources/Documents/api.html'
db  = new sqlite3.Database 'Contents/Resources/docSet.dsidx'

api('a.anchor').each (i, el) ->
    el = cheerio(el)

    name = el.parent().text().trim()
    path = "api.html##{el.attr('name')}"

    type = 'Entry'    
    if name.match /.*\..*\(.*\)/ or name.match /^Q[\.(].*/
        type = 'Function'

    db.run "INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES ('#{name}', '#{type}', '#{path}');"

    # console.log "name=#{name}, path=#{path}"


