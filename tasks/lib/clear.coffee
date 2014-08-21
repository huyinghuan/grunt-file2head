_path = require 'path'
_utils = require './utils'
grunt = require 'grunt'
class Clear
  constructor: (@data, defaultOptions)->
    @init(defaultOptions)

    @doClear()

  init: (defaultOptions)->
    #初始化config
    @config = grunt.config.get _utils.getPackageName()
    #合并options设置
    @options = @extend defaultOptions, @config.options

  #清除指定任务
  doClearTask: (taskName, task)->
    tmpOptions = @extend {}, @options
    taskOptions = @extend tmpOptions, task
    scanSourceFileDir = taskOptions.scanSourceFileDir
    legalDist = _utils.getMatchFiles scanSourceFileDir, taskOptions.dist

    @doClearTag beRemovedTagDistFilePath, taskOptions.tag, taskName for beRemovedTagDistFilePath in legalDist
    grunt.log.writeln "clear task #{taskName}"

  #清除标签
  doClearTag: (filePath, selector, taskName)->
    $ = _utils.createHtml filePath
    property = if taskName then "[grunt-type='#{taskName}']" else "[grunt-type]"
    $(selector).find(property).remove()
    _utils.writeToHtml filePath, $

  doClearFile: (src, dist)->
    dist = [].concat dist
    $ = _utils.createHtml src

    for selector in dist
      $(selector).each(()->
        $(@).remove()
      )
    _utils.writeToHtml src, $
    grunt.log.writeln "clear file #{src}'s #{dist}"

  doClear: ->
    data = @data
    #获取需要清除的任务
    tasks = data.tasks;
    tasksDataType =   grunt.util.kindOf(tasks)
    return if (tasksDataType isnt 'array') and (tasksDataType isnt 'string')
    tasks = [].concat tasks
    @doClearTask task, @config[task] for task in tasks when task

    #清空设置的文件
    src = data.src
    dist = data.dist


    return if not src or not dist
    #获取根文件夹
    sourceRootDirector = data.scanSourceFileDir or @options.scanSourceFileDir
    sourceRootDirector = '' if sourceRootDirector is false

    src = _utils.getMatchFiles sourceRootDirector, src

    @doClearFile source, dist for source in src

  extend: (son, father)->
    son[key] = value for key, value of father
    return son

module.exports = Clear