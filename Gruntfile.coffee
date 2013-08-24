module.exports = (grunt) ->

  #load external tasks and change working directory
  grunt.source.loadAllTasks()

  #initialise config
  grunt.initConfig
    source: grunt.source
    #watcher
    watch:
      scripts:
        files: 'src/**/*.coffee'
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
    uglify:
      compress:
        options:
          banner: """
            /** <%= source.title %> - v<%= source.version %>
              * <%= source.homepage %>
              * <%= template.today("YYYY") %>
              */
            """
        files:
          "dist/<%= source.name %>.min.js": "dist/<%= source.name %>.js"

  grunt.registerTask "scripts", ["coffee","uglify"]
  grunt.registerTask "default", ["scripts","watch"]
