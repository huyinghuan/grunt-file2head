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

### How to use it

If there is a directory struct:
```
app
  |- index.html
  |- css
      |- a.css, b.css
  |_ js
      |
      |-a.js, b.js
      |-lib
          |- lib.js
```

#### 1. add ```.js``` or ```.css``` file to html

```
grunt.initConfig({
  "file2head":{
    js:{
      src: ['app/lib/*.js', 'app/*.js'],
      dist: ['app/index.html']
    }
  }
})
```

result: app/index.html

```html
<html>
...
<head>
...
<script src="/app/lib/lib.js" grunt-type="js"></script>
<script src="/app/a.js" grunt-type="js"></script>
<script src="/app/b.js" grunt-type="js"></script>
</head>
...
</html>

```

#### 2. set the root directory

```
grunt.initConfig({
  "file2head":{
    js:{
      src: ['lib/*.js', '*.js'],
      dist: ['index.html'],
      scanSourceFileDir: 'app',
      scanDistFileDir: ''app'',
    }
  }
})
```

result: app/index.html

```html
<html>
...
<head>
...
<script src="/lib/lib.js" grunt-type="js"></script>
<script src="/a.js" grunt-type="js"></script>
<script src="/b.js" grunt-type="js"></script>
</head>
...
</html>

```

#### 3. set the tag where the file will be added

the default tag is ```head```. you can set the tag by yourself

```
grunt.initConfig({
  "file2head":{
    js:{
      src: ['lib/*.js', '*.js'],
      dist: ['index.html'],
      scanSourceFileDir: 'app',
      scanDistFileDir: ''app'',
      tag: "body"
    }
  }
})
```

result: app/index.html

```html
<html>
...
<head>
...
</head>
<body>
....
<script src="/lib/lib.js" grunt-type="js"></script>
<script src="/a.js" grunt-type="js"></script>
<script src="/b.js" grunt-type="js"></script>
</body>
</html>

```

you also can use the simple css selector ```tag```(but support is not complete)

```
grunt.initConfig({
  "file2head":{
    js:{
      src: ['lib/*.js', '*.js'],
      dist: ['index.html'],
      scanSourceFileDir: 'app',
      scanDistFileDir: ''app'',
      tag: "#hello"
    }
  }
})
```

result: app/index.html

```html
<html>
...
<head>
...
</head>
<body>
....
<div id="hello">
<script src="/lib/lib.js" grunt-type="js"></script>
<script src="/a.js" grunt-type="js"></script>
<script src="/b.js" grunt-type="js"></script>
</div>
...
</body>
</html>

```

#### 4.set the js file url

the defaule url is ```/```, you can set ```uri`` to control it  by yourself

```
grunt.initConfig({
  "file2head":{
    js:{
      src: ['lib/*.js', '*.js'],
      dist: ['index.html'],
      scanSourceFileDir: 'app',
      scanDistFileDir: ''app'',
      tag: "#hello",
      uri: "http://xxx.com"
    }
  }
})
```

#### 5. set default options

the setting in task will cover default options

```
grunt.initConfig({
  "file2head":{
    options:{
        scanSourceFileDir: 'app',
        scanDistFileDir: ''app'',
        dist: 'index.html',
        tag: "head",
        uri: "http://xxx.com"
    },
    js:{
      src: ['lib/*.js', '*.js'],
      tag: "#hello"
    },
    css:{
      src: ['css/*.css']
      uri: "http://www.com"
    }
  }
})
```

result: app/index.html

```html
<html>
...
<head>
...
<link rel="stylesheet" href="http://www.com/css/a.css" grunt-type="css">
<link rel="stylesheet" href="http://www.com/css/c.css" grunt-type="css">
</head>
<body>
....
<div id="hello">
<script src="http://xxx.com/lib/lib.js" grunt-type="js"></script>
<script src="http://xxx.com/a.js" grunt-type="js"></script>
<script src="http://xxx.com/b.js" grunt-type="js"></script>
</div>
...
</body>
</html>

```

#### 6. how to clear tag

##### clear task by task name

grunt.initConfig({
  "file2head":{
    options:{
        scanSourceFileDir: 'app',
        scanDistFileDir: ''app'',
        dist: 'index.html',
        tag: "head",
        uri: "http://xxx.com"
    },
    js:{
      src: ['lib/*.js', '*.js'],
      tag: "#hello"
    },
    css:{
      src: ['css/*.css']
      uri: "http://www.com"
    },
    clear:{
      tasks: ['js']
    }
  }
})
```
after run "[file2head:js, file2head:css]"
the result  app/index.html is

```html
<html>
...
<head>
...
<link rel="stylesheet" href="http://www.com/css/a.css" grunt-type="css">
<link rel="stylesheet" href="http://www.com/css/c.css" grunt-type="css">
</head>
<body>
....
<div id="hello">
<script src="http://xxx.com/lib/lib.js" grunt-type="js"></script>
<script src="http://xxx.com/a.js" grunt-type="js"></script>
<script src="http://xxx.com/b.js" grunt-type="js"></script>
</div>
...
</body>
</html>

```

after run "[file2head:clear]"
the result  app/index.html change to

```html
<html>
...
<head>
...
<link rel="stylesheet" href="http://www.com/css/a.css" grunt-type="css">
<link rel="stylesheet" href="http://www.com/css/c.css" grunt-type="css">
</head>
<body>
....
<div id="hello">
</div>
...
</body>
</html>

```

##### clear task by file name and selector

grunt.initConfig({
  "file2head":{
    options:{
        scanSourceFileDir: 'app',
        scanDistFileDir: ''app'',
        dist: 'index.html',
        tag: "head",
        uri: "http://xxx.com"
    },
    js:{
      src: ['lib/*.js', '*.js'],
      tag: "#hello"
    },
    css:{
      src: ['css/*.css']
      uri: "http://www.com"
    },
    clear:{
      src: ['*.html'],
      dist: ['head link']
    }
  }
})
```
after run "[file2head:js, file2head:css]"
the result  app/index.html is

```html
<html>
...
<head>
...
<link rel="stylesheet" href="http://www.com/css/a.css" grunt-type="css">
<link rel="stylesheet" href="http://www.com/css/c.css" grunt-type="css">
</head>
<body>
....
<div id="hello">
<script src="http://xxx.com/lib/lib.js" grunt-type="js"></script>
<script src="http://xxx.com/a.js" grunt-type="js"></script>
<script src="http://xxx.com/b.js" grunt-type="js"></script>
</div>
...
</body>
</html>

```

after run "[file2head:clear]"
the result  app/index.html change to

```html
<html>
...
<head>
...
</head>
<body>
....
<div id="hello">
<script src="http://xxx.com/lib/lib.js" grunt-type="js"></script>
<script src="http://xxx.com/a.js" grunt-type="js"></script>
<script src="http://xxx.com/b.js" grunt-type="js"></script>
</div>
...
</body>
</html>

```

##### you can use them at the some time

grunt.initConfig({
  "file2head":{
    options:{
        scanSourceFileDir: 'app',
        scanDistFileDir: ''app'',
        dist: 'index.html',
        tag: "head",
        uri: "http://xxx.com"
    },
    js:{
      src: ['lib/*.js', '*.js'],
      tag: "#hello"
    },
    css:{
      src: ['css/*.css']
      uri: "http://www.com"
    },
    clear:{
      task: ['js']
      src: ['*.html'],
      dist: ['head link']
    }
  }
})
```
after run "[file2head:js, file2head:css]"
the result  app/index.html is

```html
<html>
...
<head>
...
<link rel="stylesheet" href="http://www.com/css/a.css" grunt-type="css">
<link rel="stylesheet" href="http://www.com/css/c.css" grunt-type="css">
</head>
<body>
....
<div id="hello">
<script src="http://xxx.com/lib/lib.js" grunt-type="js"></script>
<script src="http://xxx.com/a.js" grunt-type="js"></script>
<script src="http://xxx.com/b.js" grunt-type="js"></script>
</div>
...
</body>
</html>

```

after run "[file2head:clear]"
the result  app/index.html change to

```html
<html>
...
<head>
...
</head>
<body>
....
<div id="hello">
</div>
...
</body>
</html>

```

### Grunt-config

the example config see ```klyg-file2head/Gruntfile.coffee```

```js
  grunt.initConfig({
    // Configuration to be run (and then tested).
    "file2head": {
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
         "src": ["app/js/lib/*.js"],
         "dist": "app/index.html", //if it is undefine or false will use options.dist
         "tag":"head", //if it is undefine or false will use options.tag
         "uri": "http://localhost:3000", //if it is undefine or false will use options.root
         "scanSourceFileDir": false, // it will replace options.scanSourceFileDir
         "scanDistFileDir": false, //it will replace options.scanDistFileDir
      },
      /*
      *task
      */
      "js": {
        "src": ['app/*.js', 'app/*/*.js'],
        "dist": "test/index.html",
        'tag': 'body',
      },
      /**
      * How to clear html tag?
      * 1. clear task
      *   a. set the task name be 'clear' or 'clearXXX'
      *   b. set tasks be array that contain task name that you want clear
      *     for example: tasks: ["js"]  will clear the tag that be 'js' task added
      * 2. clear file
      *   a. set the file name in src
      *   b. set the tag css selector in dist.
      *      like this: "#main", will select the tag that id is main and then remove it
      * You can use one of them or  use them at the some time
      */
      "clear":{
        "tasks": ["css"],
        "src": ["*.html"],
        "dist": ["body js"]

      }
    }
  });
```
## LICENSE
MI

see ```grunt-file2head/LICENSE-MIT```

## Historty
### v0.0.7
1. add clear file
2. add example.

### v0.0.6
1. rename task name frome ```klyg-file2heead``` to ```file2head```

### v0.0.5
1. add clear tasks

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

