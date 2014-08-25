grunt-file2head
=============
add css or js file to html tag.

[![NPM](https://nodei.co/npm/klyg-file2head.png?downloads=true&downloadRank=true&stars=true)](https://nodei.co/npm/klyg-file2head/)

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

```js
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

```js
grunt.initConfig({
  "file2head":{
    js:{
      src: ['lib/*.js', '*.js'],
      dist: ['index.html'],
      scanSourceFileDir: 'app',
      scanDistFileDir: 'app',
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

the default tag is ```head```. you can set the tag by yourself.

```js
grunt.initConfig({
  "file2head":{
    js:{
      src: ['lib/*.js', '*.js'],
      dist: ['index.html'],
      scanSourceFileDir: 'app',
      scanDistFileDir: 'app',
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

```js
grunt.initConfig({
  "file2head":{
    js:{
      src: ['lib/*.js', '*.js'],
      dist: ['index.html'],
      scanSourceFileDir: 'app',
      scanDistFileDir: 'app',
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

the defaule url is ```/```, you can set ```uri``` to control it  by yourself

```js
grunt.initConfig({
  "file2head":{
    js:{
      src: ['lib/*.js', '*.js'],
      dist: ['index.html'],
      scanSourceFileDir: 'app',
      scanDistFileDir: 'app',
      tag: "#hello",
      uri: "http://xxx.com"
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
<script src="http://xxx.com/lib/lib.js" grunt-type="js"></script>
<script src="http://xxx.com/a.js" grunt-type="js"></script>
<script src="http://xxx.com/b.js" grunt-type="js"></script>
</div>
...
</body>
</html>
```

#### 5. set default options

the setting in task will cover default options

```js
grunt.initConfig({
  "file2head":{
    options:{
        scanSourceFileDir: 'app',
        scanDistFileDir: 'app',
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

this plugin will do clean tasks that name with ```clear``` or begin with ```clear```. like ```clear```, ```clearHead``` and so on.


##### clear task by task name

```js
grunt.initConfig({
  "file2head":{
    options:{
        scanSourceFileDir: 'app',
        scanDistFileDir: 'app',
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
after run ```[file2head:js, file2head:css]```
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

after run ```[file2head:clear]```
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

```js
grunt.initConfig({
  "file2head":{
    options:{
        scanSourceFileDir: 'app',
        scanDistFileDir: 'app',
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
after run ```[file2head:js, file2head:css]```
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

after run ```[file2head:clear]```
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

```js
grunt.initConfig({
  "file2head":{
    options:{
        scanSourceFileDir: 'app',
        scanDistFileDir: 'app',
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
after run ```[file2head:js, file2head:css]```
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

after run ```[file2head:clear]```
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

#### How to add versions?

set versions infomation by fields ```parameters```

```js
grunt.initConfig({
  "file2head":{
    options:{
        scanSourceFileDir: 'app',
        scanDistFileDir: 'app',
        dist: 'index.html',
        tag: "head",
        uri: "http://xxx.com",
        parameters:"?v=#P{new Date().getTime()-v0.1}"
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
<link rel="stylesheet" href="http://www.com/css/a.css?v=1408670965087-v1.0" grunt-type="css">
<link rel="stylesheet" href="http://www.com/css/c.css?v=1408670965087-v1.0" grunt-type="css">
</head>
<body>
....
<div id="hello">
<script src="http://xxx.com/lib/lib.js?v=1408670965087-v1.0" grunt-type="js"></script>
<script src="http://xxx.com/a.js?v=1408670965087-v1.0" grunt-type="js"></script>
<script src="http://xxx.com/b.js?v=1408670965087-v1.0" grunt-type="js"></script>
</div>
...
</body>
</html>
```

## LICENSE
MIT

see ```grunt-file2head/LICENSE-MIT```

## History
### v0.0.8
1. add file url parameters

### v0.0.7
1. add clear file
2. add example.

### v0.0.6
1. rename task name frome ```klyg-file2head``` to ```file2head```

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

