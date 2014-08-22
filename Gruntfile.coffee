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
      file2head:
        options:
          parameters: "?v=#{new Date().getTime()}-v1.0"
          scanSourceFileDir: 'app'
          scanDistFileDir: 'app'
          tag: "head"
          uri: false
          dist: "index.html"
        js:
          src: ['*.js', '*/*.js']
          tag: 'body'
        css:
          src: ['*/*.css']
        clear:
          tasks: ['css']
          src: ["*.html"],
          dist: ['body script'],
          scanSourceFileDir: 'app'
  )
  grunt.loadTasks 'tasks'
  grunt.registerTask 'default', ['file2head:js', 'file2head:css']

