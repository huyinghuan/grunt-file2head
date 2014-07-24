/*
 * klyg-js2header
 * https://github.com/huyinghuan/grunt-js2head
 *
 * Copyright (c) 2014 huyinghuan
 * Licensed under the MIT license.
 */

'use strict';
var _jsdom = require('jsdom').jsdom;
var _url = require('url');
var _path = require('path');


module.exports = function(grunt) {
  grunt.registerMultiTask('klyg_file2head', 'find js file and add to tag header', function() {
    // Merge task-specific and/or target-specific options with these defaults.
    var options = this.options({
      priority: ['lib'],
      tag: "body",
      root: '/'
    });
    //遍历配置中 每个任务目标的 src字段。
    this.files.forEach(function(t){
      // t 每个任务对象
      var tag = t.tag || options.tag
      var root = t.root || options.root
      var dist = t.dist

      if(!grunt.file.exists(dist)){
        grunt.log.warn("this task don't have destination file")
        return;
      }
      console.log(t)
      var files = []

      var doc = _jsdom(grunt.file.read(dist))
      var node = doc.createElement("<script>console.log(1)</script>")
      doc.querySelector('head').appendChild(node)
      grunt.file.write(dist, doc.innerHTML, { encoding: "utf8"})
      t.src.filter(function(filepath){
        files.push(filepath)
      })
      //_path.extname(filepath)

    })
  });

};
