_path = require 'path'
_cheerio = require 'cheerio'
_url = require 'url'
grunt = require 'grunt'
Utils = module.exports = {}

kindOf = grunt.util.kindOf

#创建一个html对象
Utils.createHtml = (filePath)->
  content = grunt.file.read filePath
  _cheerio.load(content)

#写入html
Utils.writeToHtml = (filePath, $)->
  grunt.file.write filePath, $.html().replace(/\n{2,}/g, '\n')


###
  @path: 源文件的路径。
  @target： 当前任务的名称，便于区别处理不同任务。
###
Utils.createElement = (uri, path, target)->
  uri = '' if kindOf(uri) isnt 'string'
  uri += '/' if uri.lastIndexOf('/') isnt (uri.length - 1)
  ext = _path.extname(path).replace(".", "");
  path = _url.resolve(uri, path);
  console.log(path)
  dom = ''
  switch ext
    when 'js'
      dom = "<script src='#{path}' grunt-type='#{target}'></script>"
    when 'css'
      "<link rel='stylesheet' href='#{path}' grunt-type='#{target}'/>"


Utils.getFilePath = (root, dist)->
  #装成数组统一处理
  dist = [].concat dist
  #如果根目录不是字符串
  return dist if kindOf(root) isnt 'string'
  dist[index] = _path.join root, value for value, index in dist
  return dist

#该插件的名称
Utils.getPackageName = ->
  return 'file2head'

#根据扫描文件夹目录和 通配符 文件名 获取符合条件的 文件（路径）列表
Utils.getMatchFiles = (scanDirector, similarFileNames)->
  similarFileNames = [].concat similarFileNames
  result = []
  for srcFilePath in similarFileNames
    similarPath = _path.join scanDirector, srcFilePath
    result = result.concat grunt.file.expand similarPath
  return result

Utils.getTaskConfig = ->
