module.exports = (grunt) ->

  grunt.registerTask "bower", ->
    dist = grunt.config("dist") + ".js"
    bower =
      name: "jpillora/#{grunt.source.name}"
      version: grunt.source.version
      main: dist
      description: grunt.source.description
      license: grunt.source.license
      ignore: ["*", "!bower.json", "!#{dist}"]
      dependencies: {}
      devDependencies: {}
    grunt.file.write "bower.json", JSON.stringify bower, null, 2
