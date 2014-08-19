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

  #清除标签
  doClearTag: (filePath, selector, taskName)->
    $ = _utils.createHtml filePath
    property = if taskName then "[grunt-type='#{taskName}']" else "[grunt-type]"
    $(selector).find(property).remove()
    _utils.writeToHtml filePath, $

  doClearFile: ->

  doClear: ->
    data = @data
    #获取需要清除的任务
    tasks = data.tasks;
    tasksDataType =   grunt.util.kindOf(tasks)
    return if (tasksDataType isnt 'array') and (tasksDataType isnt 'string')
    tasks = [].concat tasks
    @doClearTask task, @config[task] for task in tasks when task
    @doClearFile()

  extend: (son, father)->
    son[key] = value for key, value of father
    return son

module.exports = Clear