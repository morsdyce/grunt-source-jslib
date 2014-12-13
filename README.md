grunt-source-jslib
====================

A premade Grunt environment to build JavaScript libraries with CoffeeScript,
utilizing [Grunt Source](https://github.com/jpillora/grunt-source).

## Features

Provides a `default` task which:

1. Assumes you have `src/` directory
1. Checks if there are `.coffee` files in `src/`
1. If CoffeeScript, then compile all `src/*.coffee` into `dist/<source.name>.js`
1. If JavaScript, then concat all `src/*.js` into `dist/<source.name>.js`
1. Uglify result into `dist/<source.name>.min.js`

## Features

* Compile your CoffeeScript
* Minified version

## Usage

* Install Grunt Source http://github.com/jpillora/grunt-source

* Create a `Gruntsource.json`:

  ``` json
  {
    "name": "...",
    "title": "...",
    "version": "0.1.0",
    "homepage": "https://github.com/jpillora/...",
    "author": "Jaime Pillora <dev@jpillora.com>",
    "source": "~/Code/JavaScript/grunt-source-jslib",
    "repo": "https://github.com/jpillora/grunt-source-jslib.git",
    "jquery": false,
    "bower": true
  }
  ```
    * `jquery` denotes whether to create jQuery plugin manifest
    * `bower` denotes whether to create bower manifest

* Optionally create a `vendor/` directory with some `*.js` files

* Create `src/` directory with some `*.js|coffee` files

* Run `grunt-source`

## Grunt Options

* Web Server `--server=<port>`
* Live Reload `--livereload=false`
* Show Filesize Report `--report=true`

## Contributing

1. Fork [this repo](https://github.com/jpillora/grunt-source-jslib)
2. Edit your `GruntSource.json` file's `repo` to be the new Git URL
3. Edit your `GruntSource.json` file's `source` to reference a new directory
4. Rerun `grunt-source`
5. Push your changes
6. Pull-request for others to enjoy

## Todo

* Come up with a `test` task which applies to most JS libraries

#### MIT License

Copyright © 2013 Jaime Pillora &lt;dev@jpillora.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

