###
 # klyg-js2header
 # https://github.com/huyinghuan/grunt-js2head
 #
 # Copyright (c) 2014 huyinghuan
 # Licensed under the MIT license.
###
'use strict'

module.exports = (grunt)->
  grunt.initConfig(
      pkg: grunt.file.readJSON "package.json"
      klyg_file2head:
        options:
          fileRootDir: false
          tag: "head"
          uri: "/"
          replaceDirWithBlank: 'test'
          dist: "test/index.html"
        js:
          "src": ['test/*.js', 'test/*/*.js']
          "dist": "test/index.html"
          'tag': 'body'
  )
  grunt.loadTasks 'tasks'
  grunt.loadTasks './test'
  grunt.registerTask 'default', ['klyg_file2head:js']

