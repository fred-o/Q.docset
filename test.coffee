cheerio = require 'cheerio'
fs      = require 'fs'
sqlite3 = require 'sqlite3'

api = cheerio.load fs.readFileSync 'Contents/Resources/Documents/api.html'
db  = new sqlite3.Database 'Contents/Resources/docSet.dsidx'

# console.log api('a[name=user-content-promiseallsettled]').parent().text()
api('a.anchor').each (i, el) ->
    el = cheerio(el)

    name = el.parent().text().trim()
    path = "api.html##{el.attr('name')}"

    db.run "INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES ('#{name}', 'Function', '#{path}');"

    console.log "name=#{name}, path=#{path}"


