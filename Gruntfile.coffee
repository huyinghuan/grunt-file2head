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
          scanSourceFileDir: 'app'
          scanDistFileDir: 'app'
          tag: "head"
          uri: false
          dist: "index.html"
        js:
          "src": ['*.js', '*/*.js']
          'tag': 'body'
        css:
          "src": ['*/*.css']
  )
  grunt.loadTasks 'tasks'
  grunt.registerTask 'default', ['klyg_file2head:js', 'klyg_file2head:css']

