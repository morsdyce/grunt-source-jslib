module.exports = (grunt) ->

  grunt.registerTask "bower", ->
    
    src = grunt.source
    dist = grunt.config("dist") + ".js"

    bower =
      name: src.repoId or "jpillora/#{src.name}"
      version: src.version
      main: dist
      description: src.description
      license: src.license
      ignore: ["*", "!bower.json", "!#{dist}"]
      dependencies: {}
      devDependencies: {}
    grunt.file.write "bower.json", JSON.stringify bower, null, 2
