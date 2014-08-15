grunt-js2head
=============

## install

```shell
npm install klyg-file2head
```

or package.json

```js
    ...
    "devDependencies": {
        "grunt": "~0.4.5",
        "klyg-file2head":""
    },
    ...
```

## Using

### Example
```shell
  cd klyg-file2head
```
see ```Gruntfile.coffee``` and ```app``` directory and then

```shell
#run
grunt
```
watch the change of index.html after ```grunt```


### Grunt-config

```js
  grunt.initConfig({
    // Configuration to be run (and then tested).
    "klyg_file2head": {
      options: {
        /**
        * The html tag which the .js or .css will be added.
        * String. Default: "head"
        * Support CSS seletor.(in the plugin use document.querySelector(tag) choose the dist tag)
        **/
        "tag": "head",
        /*
        * the root uri
        * String. Default: "/"
        * can set like:  http://localhost/xxx/xx 
        * the result is: http://localhost/xxx/xx/xx.js
        */
        "uri": "/"
        /*
        *  the html file path which the .js or .css will be added.
        *  String or Boolean. Default: false
        */
        "dist": "index.html",
        /*
        * set the source file directory that need be scaled
        * String or Boolean. Default: false
        * eg.   scaleSourceFileDir: 'app', src:[js/*.js]
        * the file *.js in app/js  will be found
        */
        "scanSourceFileDir": false,
         /*
          * set the dist file directory that need be scaled
          * String or Boolean. Default: false
          * eg.   scanDistFileDir: 'app', dist: 'index.html'
          * the file app/index.html  will be as dist file
          */
         "scanDistFileDir": false,
      },
      /*
      *task
      */
      "lib": { 
         "src": ["test/js/lib/*.js"],
         "dist": "test/index.html", //if it is undefine or false will use options.dist
         "tag":"head", //if it is undefine or false will use options.tag
         "uri": "http://localhost:3000", //if it is undefine or false will use options.root
         "scanSourceFileDir": false, // it will replace options.scanSourceFileDir
         "scanDistFileDir": false, //it will replace options.scanDistFileDir
      },
      /*
      *task
      */
      "js": {
        "src": ['test/*.js', 'test/*/*.js'],
        "dist": "test/index.html",
        'tag': 'body',
      },
      /**
      * How to clear html tag?
      * set the task name be 'clear' and tell grunt which files need remove tag by "src" property
      */
      "clear":{
        "src": ["index.html", "*.html"],
        "dist":["head", "@js", "$input"]
      }
    }
  });
```
##LICENSE

MIT

see ```grunt-file2head/LICENSE-MIT```

##Historty

### v0.0.4
1. replace jsdom with cheerio
2. rewrite all file with coffeescript
3. undo:  clear task

### v0.0.3
Temp version

1. Fix a bug.
  when there are dirs in "src" can't resolve

2. Add a function.
  remove the html tags from html file

