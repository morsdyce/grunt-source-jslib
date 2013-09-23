
http = require 'http'
url = require 'url'

module.exports = (grunt) ->

  async = grunt.util.async

  grunt.registerTask 'webget', ->

    files = []
    for src, dest of grunt.config 'webget'
      files.push { src, dest }
    return unless files.length

    #fetch each
    done = @async()

    fetch = (file, callback) ->

      try
        u = url.parse file.src
      catch e
        return callback e

      body = ''

      opts =
        hostname: u.hostname
        path: u.path

      req = http.request opts, (res) ->
        res.on 'data', (c) ->
          body += c
        res.on 'end', ->
          grunt.log.ok "Saved '#{file.src}' in '#{file.dest}'"
          grunt.file.write file.dest, body
          callback null

      req.on 'error', callback
      req.end()

    async.map files, fetch, (err, results) ->
      if err
        return grunt.fail.warn err
      done()



