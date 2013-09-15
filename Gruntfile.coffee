module.exports = (grunt) ->

  #load creds
  aws = if grunt.file.exists "aws.json" then grunt.file.readJSON "aws.json" else {}

  #load external tasks and change working directory
  grunt.source.loadAllTasks()

  versions = grunt.source.version.split('.')
  compat = versions[0]
  compat += "." + versions[1] if compat is "0"

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
        livereload: true
      scripts:
        files: ['vendor/**/*.js','src/**/*.{js,coffee}']
        tasks: 'scripts'
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
          banner: "<%= banner %>(function(window,document#{if jquery then ',$' else ''},undefined) {\n"
          footer: "}(window,document#{if jquery then ',jQuery' else ''}));"
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

  pkg = []
  pkg.push "jquery" if jquery

  grunt.registerTask "scripts", ["coffee","concat","uglify"]
  grunt.registerTask "package", pkg
  grunt.registerTask "default", ["package","scripts","watch"]
