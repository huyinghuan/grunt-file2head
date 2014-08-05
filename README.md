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
see ```Gruntfile.js``` and ```test``` directory

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
        "uri": "/",
        /*
        * the path will be replace withe space
        * String or Boolean. Default: false
        * if it is a String 'xxx' and the aa.js in directory xxx/hello
        * result:  [root]/hello/aa.js
        */
        "replaceDirWithBlank": 'test',
        /*
        *  the html file path which the .js or .css will be added.
        *  String or Boolean. Default: false
        */
        "dist": "index.html"
      },
      /*
      *task
      */
      "lib": { 
         "src": ["test/js/lib/*.js"],
         "dist": "test/index.html", //if it is undefine or false will use options.dist
         "tag":"head", //if it is undefine or false will use options.tag
         "uri": "http://localhost:3000", //if it is undefine or false will use options.root
         "replaceDirWithBlank": false, //if it is undefine or false will use options.replaceDirWithBlank
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


##Historty

### v0.0.3
Temp version

1. Fix a bug.
  when there are dirs in "src" can't resolve

2. Add a function.
  remove the html tags from html file

