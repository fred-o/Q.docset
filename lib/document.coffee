module.exports = class Document
    constructor: (@fileName, @index) ->

    add: (name, type, anchor) ->
        @index.run "INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES ('#{name}', '#{type}', '#{@fileName}##{anchor}');"

