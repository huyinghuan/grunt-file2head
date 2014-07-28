/*
 * klyg-js2header
 * https://github.com/huyinghuan/grunt-js2head
 *
 * Copyright (c) 2014 huyinghuan
 * Licensed under the MIT license.
 */

'use strict';

module.exports = function(grunt) {
  // Project configuration.
  grunt.initConfig({
    // Configuration to be run (and then tested).
    klyg_file2head: {
      options: {
        tag: "head",
        root: "/",
        delDir: 'test',
        dist: "test/index.html"
      },
      lib: {
         "src": ["test/js/lib/*.js"]
      },
      js: {
        "src": ['test/*.js', 'test/*/*.js'],
        "dist": "test/index.html",
        'tag': 'body'
      },
      css:{
        "src": ['test/*.css', 'test/*/*.css'],
        'tag': 'head'
      }
    }
  });
  grunt.loadTasks('tasks');
  grunt.registerTask('default', ['klyg_file2head']);

};
