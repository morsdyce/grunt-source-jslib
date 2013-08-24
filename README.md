grunt-source-jslib
====================

A premade Grunt environment to build JavaScript libraries with CoffeeScript,
utilizing [Grunt Source](https://github.com/jpillora/grunt-source).

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
  "repo": "https://github.com/jpillora/grunt-source-jslib.git"
}
```

* Run `grunt-source`

## Customising

1. Fork [this repo](https://github.com/jpillora/grunt-source-web)
2. Edit your `GruntSource.json` file's `repo` to be the new Git URL
3. Edit your `GruntSource.json` file's `source` to reference a new directory
4. Rerun `grunt-source`
5. Push your changes
6. Pull-request for others to enjoy
