
module.exports = (grunt) ->

  src = grunt.source

  pureName = src.name
  if /^jquery\.(.+)/.test src.name
    pureName = RegExp.$1

  grunt.registerTask "jquery", ->

    plugin =
      name: src.name
      version: src.version
      title: src.title
      description: src.description
      author:
        name: src.author or 'Jaime Pillora'
      license: src.license or 'MIT',
      keywords: src.keywords,
      homepage: src.homepage,
      bugs: src.homepage + '/issues',
      docs: src.homepage,
      download: src.homepage,
      dependencies:
        jquery: ">=1.6"

    grunt.file.write "#{pureName}.jquery.json", JSON.stringify plugin, null, 2