_path = require 'path'
_utils = require './utils'
class Clear
  constructor: (@grunt, @data, defaultOptions)->
    @init(defaultOptions)

    @doClear()

  init: (defaultOptions)->
    #初始化config
    @config = @grunt.config.get('klyg_file2head')
    #合并options设置
    @options = @extend defaultOptions, @config.options

  doClearTask: (taskName, task)->
    grunt = @grunt
    tmpOptions = @extend {}, @options
    taskOptions = @extend tmpOptions, task
    scanSourceFileDir = taskOptions.scanSourceFileDir
    dist = [].concat taskOptions.dist
    legalDist = []
    for distFilePath in dist
      similarPath = _path.join(scanSourceFileDir, distFilePath)
      legalDist = legalDist.concat grunt.file.expand similarPath

    @doClearTag beRemovedTagDistFilePath, taskOptions.tag, taskName for beRemovedTagDistFilePath in legalDist

  doClearTag: (filePath, selector, taskName)->
    grunt = @grunt
    $ = _utils.createHtml grunt.file.read filePath
    property = if taskName then "[grunt-type='#{taskName}']" else "[grunt-type]"
    $(selector).find(property).remove()
    grunt.file.write filePath, $.html().replace(/\n{2,}/g, '\n')

  doClearFile: ->

  doClear: ->
    data = @data
    grunt = @grunt
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