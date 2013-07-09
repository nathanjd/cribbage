templateDir = 'src/templates/'
handlebarsPath = templateDir + '*.hbs'

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    clean: ['compiled/']
    coffee:
      compile:
        options:
          sourceMap: true          
        files:
          'compiled/js/app.js': 'src/js/app.coffee'
          'compiled/js/cribbage.js': 'src/js/cribbage.coffee'
          'compiled/js/player.js': 'src/js/player.coffee'
          'compiled/js/deck.js': 'src/js/deck.coffee'
          'compiled/js/card.js': 'src/js/card.coffee'
    copy:
      main:
        files: [
          {dest: 'compiled/index.html', src: 'src/index.html'},
          {dest: 'compiled/js/main.js', src: 'src/js/main.js'}
        ]
    handlebars:
      compile:
        options:
          namespace: 'templates'
          amd: true
          processName: (filename) ->
            return filename.split(templateDir)[1].split('.hbs')[0]
        files:
          'compiled/js/templates.js': handlebarsPath
    sass:
      dist:
        files:
          'compiled/css/style.css': 'src/css/base.scss'
    watch:
      coffee:
        files: ['src/js/**/*.coffee']
        tasks: ['coffee']
      copy:
        files: ['src/index.html']
        tasks: ['copy']
      handlebars:
        files: [handlebarsPath]
        tasks: ['handlebars']
      sass:
        files: ['src/css/**/*.scss']
        tasks: ['sass']

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-handlebars'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default',
    ['clean', 'coffee', 'copy', 'handlebars', 'sass']
