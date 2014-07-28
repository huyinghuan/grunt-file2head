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
var utils = {};

utils.createScript = function(doc, src, target){
  var node = doc.createElement('script');
  node.setAttribute('src', src);
  node.setAttribute("grunt-type", target);
  return node
};

utils.createCSS = function(doc, src, target){
  var node = doc.createElement('link');
  node.setAttribute('rel', 'stylesheet');
  node.setAttribute('href', src);
  node.setAttribute("grunt-type", target);
  return node
};

utils.removeAllExists = function(doc, tag, target){
  var hasAppended = doc.querySelectorAll(tag + ' > [grunt-type="'+target+'"]');
  for(var i = 0, length = hasAppended.length; i < length; i++){
    var node = hasAppended[i];
    node.parentNode.removeChild(node)
  }
  var main  = doc.querySelector(tag)
  main.innerHTML = main.innerHTML.replace(/(\n){2,}/g, '')
};


utils.createElement = function(doc, path, target){
  var ext = _path.extname(path).replace(".", "");
  switch(ext){
    case 'js':
      return utils.createScript(doc, path, target);
    case 'css':
      return utils.createCSS(doc, path, target);
  }
  return null;
};


module.exports = function(grunt) {
  grunt.registerMultiTask('klyg_file2head', 'find js file and add to tag header', function() {
    // Merge task-specific and/or target-specific options with these defaults.
    var options = this.options({
      delDir: false,
      dist: false,
      tag: "body",
      root: '/'
    });

    //本次目标
    //this.target
    var target = this.target;
    //1.  获取目标文件内存对象
    //判断目标文件是否存在 生成默认浏览器对象
    if(options.dist && grunt.file.exists(options.dist)){
      var defDoc = _jsdom(grunt.file.read(options.dist));
    }

    //遍历配置中 每个任务目标的 src字段。
    this.files.forEach(function(t){ // t 每个任务对象
      //需要文件将放入的标签
      var tag = t.tag || options.tag;
      //应用的根目录
      var root = t.root || options.root;
      //目标HTML文件
      var dist = t.dist
      //需要替换为空的文件夹
      var  delDir = t.delDir || options.delDir;

      var doc = null
      //判断目标文件是否存在
      if(dist === options.dist && defDoc){
        doc = defDoc;
      }else if(dist && grunt.file.exists(dist)){
        doc = _jsdom(grunt.file.read(options.dist));
      }else if(!dist && defDoc){
        dist = options.dist
        doc = defDoc
      }
      if(!doc){
        console.warn("task distation isnot exists!")
        return
      }
      //2.清除重复标签
      utils.removeAllExists(doc, tag, target);
      //3.获取将被插入 的元素
      var beInsertTag = doc.querySelector(tag);
      t.src.filter(function(uri){
        //替换掉不需要的文件夹前缀
        if(options.delDir !== false){
          uri = uri.replace(delDir, "");
        }
        var src = _url.resolve(root, uri);
        //创建dom节点 并插入节点
        beInsertTag.appendChild(utils.createElement(doc, src, target));
        beInsertTag.innerHTML += "\n";
      });
      //写入到文件
      grunt.file.write(dist, new Buffer(doc.innerHTML), { encoding: "utf8"});
    })
  });

};