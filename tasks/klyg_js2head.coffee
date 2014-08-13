_utils = require './lib/utils'
_path = require 'path'
module.exports = (grunt)->
  grunt.registerMultiTask 'klyg_file2head',
      'find js file and add to tag header',
      ()->
        options = this.options(
          fileRootDir: false,
          replaceDirWithBlank: false,
          dist: false,
          tag: "head",
          uri: '/'
        )
        #目标任务
        taskName = @target

        #是否是清除任务 #后续完善
        #return _until.clear this, grunt if taskName is 'clear' or taskName.indexOf 'clear' is 0

        kindOf = grunt.util.kindOf

        #是否有默认设置目标文件
        if kindOf options.dist is 'string'
          #是否设置目标文件的根目录
          distFilePath = _utils.getFilePath options.fileRootDir, options.dist
          #创建默认的Html 对象
          defaultHtmlDom = _utils.createHtml grunt.file.read distFilePath if grunt.file.exists distFilePath

        console.log @

        data = @data

        #获取目标文件
        dist = data.dist or options.dist
        fileRootDir = data.fileRootDir or options.fileRootDir
        #如果目标文件不是数组或者字符串。则报错返回
        distType = kindOf(dist)
        return grunt.log.error 'dist fields is illegal' if (distType isnt 'string') and (distType isnt  'array')
        #获取目标文件
        dist = _utils.getFilePath fileRootDir, dist, distType

        legalDist = []

        #判断目标文件是否存在
        for distFilePath in dist
          if grunt.file.exist distFilePath
            legalDist.push distFilePath
          else
            grunt.log.writeln "#{distFilePath} is not exists"
        #存在的目标文件为空
        return grunt.log.writeln "dist file is null" if legalDist.length is 0

        src = data.src
        srcType = kindOf src
        #判断源文件是否进行了设置
        return grunt.log.error "source file is null" if ((srcType isnt 'array') and (srcType isnt 'string')) or (src.length is 0)
        #字符转数组。
        src = [].concat src
        legalSrc = []
        legalSrc = legalSrc.concat(grunt.file.expand(srcFilePath)) for srcFilePath in src


