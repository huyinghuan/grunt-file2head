#测试工具类的正确性
_cheerio = require 'cheerio'
module.exports = (grunt)->
  grunt.registerTask('createDom', '根据html内容创建document对象', ()->
    content = "<div>
                  <span>1</span>
                  <span>2</span>
                </div>"


    $ = _cheerio.load content
    $('div').append '<script src="123.js"></script>'
    console.log $.html()

  )

  grunt.registerTask('createDom2', '根据html内容创建document对象', ()->
    content = "<head></head><body></body>"
    $ = _cheerio.load content
    $('head').append '<script src="123.js"></script>'
    console.log $.html()
  )


  grunt.registerTask 'creat', ['createDom', 'createDom2']

  grunt.registerTask('remove1', '根据html内容移除dom', ()->
    content = '''
    <head>
    <script src="123.js" grunt="123"></script>
    <script src="123.js" grunt="123"></script>
    </head>
    <body></body>
    '''
    $ = _cheerio.load content

    $('head').find('script[grunt="123"]').remove()
    console.log $.html()
    $('head').html $('head').html().replace /(\n){2,}/g, '\n'
    console.log $.html()
  )

  grunt.registerTask('remove', ['remove1'])