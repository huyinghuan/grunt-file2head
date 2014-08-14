_path = require 'path'
_cheerio = require 'cheerio'
_url = require 'url'
Utils = module.exports = {}

Utils.clear = (task, grunt)->
  console.log task

Utils.createHtml = (content)->
  _cheerio.load(content)

###
  @path: 源文件的路径。
  @target： 当前任务的名称，便于区别处理不同任务。
###
Utils.createElement = (uri, path, target)->
  uri = '' if typeof uri isnt 'string'
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
  return dist if typeof root isnt 'string'
  dist[index] = _path.join root, value for value, index in dist
  return dist