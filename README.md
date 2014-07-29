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

```json
  grunt.initConfig({
    // Configuration to be run (and then tested).
    klyg_file2head: {
      options: {
        /**
        * The html tag which the .js or .css will be added.
        * String. Default: "head"
        * Support CSS seletor.(in the plugin use document.querySelector(tag) choose the dist tag)
        **/
        tag: "head",
        /*
        * the root url
        * String. Default: "/"
        * can set like:  http://localhost/xxx/xx 
        * the result is: http://localhost/xxx/xx/xx.js
        */
        root: "/",
        /*
        * the path will be replace withe space
        * String or Boolean. Default: false
        * if it is a String 'xxx' and the aa.js in directory xxx/hello
        * result:  [root]/hello/aa.js
        */
        delDir: 'test',
        /*
        *  the html file path which the .js or .css will be added.
        *  String or Boolean. Default: false
        */
        dist: "index.html"
      },
      /*
      *task
      */
      lib: { 
         "src": ["test/js/lib/*.js"],
         "dist": "test/index.html", //if it is undefine or false will use options.dist
         "tag":"head", //if it is undefine or false will use options.tag
         "root": "http://localhost:3000", //if it is undefine or false will use options.root
         "delDir": false, //if it is undefine or false will use options.delDir
      },
      /*
      *task
      */
      js: {
        "src": ['test/*.js', 'test/*/*.js'],
        "dist": "test/index.html",
        'tag': 'body',
      },
      /**
      * How to clear html tag?
      * set the task name be 'clear' and tell grunt which files need remove tag by "src" property
      */
      clear:{
        src: ["index.html", "*.html"],
        dist:["head", "@js", "$input"]
      }
    }
  });
```


##Historty
