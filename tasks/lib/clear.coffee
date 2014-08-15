
class Clear
  constructor: (@grunt, @data, defaultOptions)->
    @init(defaultOptions)

    @doClear()

  init: (defaultOptions)->
    #初始化config
    @config = @grunt.config.get('klyg_file2head')
    #合并options设置
    @options = @extend defaultOptions, @config.options
    console.log @options

  doClearTask: ->

  doClearFile: ->

  doClear: ->
    grunt = @grunt
    data = @data

  extend: (son, father)->
    son[key] = value for key, value of father
    return son

module.exports = Clear

#  { nameArgs: 'klyg_file2head:clear-js',
#  name: 'klyg_file2head',
#  args: [],
#  flags: {},
#  async: [Function],
#  errorCount: [Getter],
#  requires: [Function],
#  requiresConfig: [Function],
#  options: [Function],
#  target: 'clear-js',
#  data: { clear: true },
#  files: [],
#  filesSrc: [Getter] }
#
#  { options:
#   { scanSourceFileDir: 'app',
#     scanDistFileDir: 'app',
#     tag: 'head',
#     uri: false,
#     dist: 'index.html' },
#  js: { src: [ '*.js', '*/*.js' ], tag: 'body' },
#  css: { src: [ '*/*.css' ] },
#  'clear-js': { clear: true } }