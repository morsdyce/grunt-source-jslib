module.exports = (grunt) ->

  #load external tasks and change working directory
  grunt.source.loadAllTasks()

  #initialise config
  grunt.initConfig
    source: grunt.source
    banner: """
      // <%= source.title %> - v<%= source.version %> - <%= source.homepage %>
      // <%= source.author %> - <%= source.license %> Copyright <%= grunt.template.today(\"yyyy\") %>\n
      """
    #watcher
    watch:
      scripts:
        files: ['vendor/**/*.js','src/**/*.coffee']
        tasks: 'scripts'
    #tasks
    coffee:
      compile:
        files:
          #init then all then run
          "dist/<%= source.name %>.js": [
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
      wrap:
        options:
          banner: "<%= banner %>(function(window,document,undefined) {\n"
          footer: "}(window,document));"
        src: ['vendor/**/*.js','dist/<%= source.name %>.js']
        dest: 'dist/<%= source.name %>.js'

    uglify:
      compress:
        options:
          banner: "<%= banner %>"
          report: if grunt.option("report") then "gzip" else false
        files:
          "dist/<%= source.name %>.min.js": "dist/<%= source.name %>.js"

  grunt.registerTask "scripts", ["coffee","concat","uglify"]
  grunt.registerTask "default", ["scripts","watch"]
