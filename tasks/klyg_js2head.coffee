_utils = require './lib/utils'
_path = require 'path'
_Clear = require './lib/clear'
module.exports = (grunt)->

  grunt.registerMultiTask 'klyg_file2head',
      'find js file and add to tag header',
      ()->
        defaultOptions =
          scanSourceFileDir: false,
          scanDistFileDir: false,
          dist: false,
          tag: "head",
          uri: '/'

        options = this.options defaultOptions

        #目标任务
        taskName = @target
        #是否是清除任务 #后续完善
        return new _Clear grunt, @data, defaultOptions if (taskName is 'clear') or (taskName.indexOf('clear-') is 0)
        console.log 1
        kindOf = grunt.util.kindOf
        data = @data
        #获取目标文件
        dist = data.dist or options.dist
        scanDistFileDir = if data.scanDistFileDir is false then '' else (data.scanDistFileDir or options.scanDistFileDir)
        #如果目标文件不是数组或者字符串。则报错返回
        distType = kindOf(dist)
        return grunt.log.error 'dist fields is illegal' if (distType isnt 'string') and (distType isnt  'array')
        #获取目标文件
        dist = _utils.getFilePath scanDistFileDir, dist

        legalDist = []

        #判断目标文件是否存在
        for distFilePath in dist
          if grunt.file.exists distFilePath
            legalDist.push distFilePath
          else
            grunt.log.writeln "#{distFilePath} is not exists"
        #存在的目标文件为空
        return grunt.log.writeln "dist file is null" if legalDist.length is 0

        src = data.src
        srcType = kindOf src
        scanSourceFileDir = if data.scanSourceFileDir is false then '' else (data.scanSourceFileDir or options.scanSourceFileDir)
        #判断源文件是否进行了设置
        return grunt.log.error "source file is null" if ((srcType isnt 'array') and (srcType isnt 'string')) or (src.length is 0)
        #字符转数组。
        src = [].concat src
        legalSrc = []
        legalSrc = legalSrc.concat(grunt.file.expand(_path.join(scanSourceFileDir, srcFilePath))) for srcFilePath in src

        #资源css，js
        assets = []
        uri = if data.uri is false then '' else (data.uri or options.uri)
        for path in legalSrc
          path = path.replace("#{scanSourceFileDir}/", '')
          assets.push _utils.createElement uri, path, taskName

        assets = assets.join('\n')

        tag = data.tag or options.tag
        return grunt.log.error "#{tag} is not exists" if kindOf(tag) isnt 'string'

        for beAppendedDistFile in legalDist
          $ = _utils.createHtml grunt.file.read beAppendedDistFile
          $(tag).find("[grunt-type='#{taskName}']").remove()
          #console.log $.html()
          dtag = $(tag)
          #如果选择器不存在，则继续下一个
          continue if dtag.length is 0
          dtag = dtag.first()
          #添加资源
          dtag.append "#{assets}\n"
          #写入文件
          grunt.file.write beAppendedDistFile, $.html().replace(/\n{2,}/g, '\n')
