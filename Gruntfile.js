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
        priority: ['lib'],
        tag: "head"
      },
      js: {
        "src": ['test/*', 'test/*/*'],
        "dist": "test/index.html",
        tag: 'body'
      },
      css:{
        "src": ['test/*'],
        "dist": "index.html",
        tag: 'head'
      }
    }
  });
  grunt.loadTasks('tasks');
  grunt.registerTask('default', ['klyg_file2head']);

};
