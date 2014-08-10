require 'coffee-script/register'

fs     = require 'fs'
path   = require 'path'
Docset = require './lib/docset'

docDir = path.join 'Contents', 'Resources', 'Documents'

task 'build', '(re)build the Docset', (options) ->
    docset = new Docset
    fs.readdir docDir, (err, files) ->
        throw err if err
        docset.parse path.join(docDir, file) for file in files when file.match /.*\.html/
