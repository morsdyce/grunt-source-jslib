

module.exports = (grunt) ->

  #load creds
  aws = if grunt.file.exists "aws.json" then grunt.file.readJSON "aws.json" else {}

  #load external tasks and change working directory
  grunt.source.loadAllTasks()

  versions = grunt.source.version.split('.')
  compat = versions[0] + (if versions[0] is "0" then "." + versions[1] else "")

  #jquery plugin
  jquery = grunt.source.jquery

  #initialise config
  grunt.initConfig
    source: grunt.source
    compat: compat
    dist: "dist/<%= compat %>/<%= source.name %>"

    banner: """
      // <%= source.title %> - v<%= source.version %> - <%= source.homepage %>
      // <%= source.author %> - <%= source.license %> Copyright <%= grunt.template.today(\"yyyy\") %>\n
      """

    #watcher
    watch:
      options:
        livereload: grunt.option('livereload')
      scripts:
        files: ['vendor/**/*.js','src/**/*.{js,coffee}']
        tasks: 'scripts'

    #file server
    connect:
      server:
        options:
          hostname: "0.0.0.0"
          port: 3000
          
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
      wrap:
        options:
          banner: "<%= banner %>(function(window#{if jquery then',$'else''},undefined) {"
          footer: "}(this#{if jquery then',jQuery'else''}));"
        src: ['vendor/**/*.js', 'src/**/*.js', '<%= dist %>.js']
        dest: '<%= dist %>.js'

    uglify:
      compress:
        options:
          banner: "<%= banner %>"
          report: if grunt.option("report") then "gzip" else false
        files:
          "<%= dist %>.min.js": "<%= dist %>.js"

    aws: aws
    s3:
      options:
        accessKeyId: "<%= aws.accessKeyId %>"
        secretAccessKey: "<%= aws.secretAccessKey %>"
      aus:
        options:
          bucket: "jpillora-aus"
        src: "<%= dist %>.js"
        dest: "<%= source.name %>/<%= compat %>.min.js"
      usa:
        options:
          bucket: "jpillora-usa"
        src: "<%= dist %>.js"
        dest: "<%= source.name %>/<%= compat %>.min.js"

  pkg = ["bower"]
  pkg.push "jquery" if jquery

  grunt.registerTask "scripts", ["coffee","concat","uglify"]
  grunt.registerTask "package", pkg


  def = ["package","scripts"]
  def.push "connect" if grunt.option("server")
  def.push "watch"

  grunt.registerTask "default", def
