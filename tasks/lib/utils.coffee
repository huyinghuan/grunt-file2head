_path = require 'path'
_cheerio = require 'cheerio'

Utils = module.exports = {}

Utils.clear = (task, grunt)->
  console.log task

Utils.createHtml = (content)->
  _cheerio.load(content)

Utils.createScript = (src, type)->
  "<script src='#{src}' grunt-type='type'></script>"

Utils.createElement = (path)->
  ext = _path.extname(path).replace(".", "");
  dom = ''
  switch ext
    when 'js'
      dom = "<script src='#{path}' grunt-type='#{ext}'></script>"
    when 'css'
      "<link rel='stylesheet' href='#{path}' grunt-type='#{ext}'/>"

Utils.getFilePath = (root, dist, distType)->
  #装成数组统一处理
  dist = [].concat dist
  #如果根目录不是字符串
  return dist if typeof root isnt 'string'
  dist[index] = _path.join root, value for value, index in dist
  return dist