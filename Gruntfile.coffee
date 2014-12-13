glob = require "glob-all"

module.exports = (grunt) ->

  #load external tasks and change working directory
  grunt.source.loadAllTasks()

  #jquery plugin
  jquery = grunt.source.jquery
  #gen bower.json
  bower = grunt.source.bower
  #server cli option
  serverPort = grunt.option("server")
  serverPort = 3000 if serverPort is true

  #initialise config
  grunt.initConfig
    source: grunt.source
    dist: "dist/<%= source.name %>"

    banner: """
      // <%= source.title %> - v<%= source.version %> - <%= source.homepage %>
      // <%= source.author %> - <%= source.license %> Copyright <%= grunt.template.today(\"yyyy\") %>\n
      """

    #watcher
    watch:
      options:
        livereload: grunt.option('livereload')
      scripts:
        files: ['Gruntsource.json','vendor/**/*.js','src/**/*.{js,coffee}']
        tasks: 'scripts'

    #file server
    connect:
      server:
        options:
          hostname: "0.0.0.0"
          port: serverPort
          
    #tasks
    coffee:
      compile:
        files:
          #init then all then run
          "<%= dist %>.js": [
            "src/init.coffee",
            "src/**/*.coffee",
            #remove and re-add to insert at bottom
            "!src/run.coffee",
            "src/run.coffee"
          ]
        options:
          bare: true
          join: true
          sourceMap: grunt.option("source-map")
    concat:
      vanilla:
        files:
          #init then all then run
          "<%= dist %>.js": [
            "src/init.js",
            "src/**/*.js",
            #remove and re-add to insert at bottom
            "!src/run.js",
            "src/run.js"
          ]
      wrap:
        options:
          banner: "<%= banner %>(function(window,#{if jquery then'$,'else''}undefined) {\n"
          footer: "\n}.call(this,window#{if jquery then',jQuery'else''}));"
        src: ['vendor/**/*.js', '<%= dist %>.js']
        dest: '<%= dist %>.js'

    uglify:
      compress:
        options:
          banner: "<%= banner %>"
          report: if grunt.option("report") then "gzip" else false
        files:
          "<%= dist %>.min.js": "<%= dist %>.js"

  pkg = []
  pkg.push "bower" if bower
  pkg.push "jquery" if jquery

  #choose between coffeescript or javascript
  compileTask = if glob.sync("src/**/*.coffee")?.length > 0 then "coffee" else "concat:vanilla"
  grunt.log.ok "task: #{compileTask}"

  grunt.registerTask "scripts", [compileTask,"concat:wrap","uglify"]
  grunt.registerTask "package", pkg

  def = ["package","scripts"]
  def.push "connect" if serverPort
  def.push "watch"

  grunt.registerTask "default", def
