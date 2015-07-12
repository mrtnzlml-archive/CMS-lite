module.exports = (grunt) ->
  grunt.initConfig

    less:
      admin:
        files:
          'temp/grunt/admin.css': [
            'vendor-client/admin/style.less'
          ]
      front:
        files:
          'temp/grunt/front.css': [# FIXME: jak na soubory nových rozšíření?
            'vendor-client/bootstrap/less/bootstrap.less'
          ]

    cssmin:
      options:
        keepSpecialComments: 0
      admin:
        files:
          'www/css/admin.min.css': [
            'temp/grunt/admin.css'
            'vendor-client/admin/aicons/styles.css'
            'vendor-client/admin/aicons/flaticon.css'
          ]
      front:
        files:
          'www/css/front.min.css': [
            'temp/grunt/front.css'
            'vendor-client/front/front.css'
          ]

    uglify:
      admin:
        files:
          'www/js/admin.min.js': [
            'vendor-client/bootstrap/js/bootstrap.js'
            'vendor-client/bootstrap/js/tooltip.js'
            'vendor-client/modules/flexslider/2_2/js/jquery.flexslider-min.js'
            'modules/pretty_photo/js/jquery.prettyPhoto.js'
            'js/html5shiv.min.js'
            'js/respond.min.js'
            'js/main.js'
          ]

    copy:
      main:
        files: [
          expand: true
          flatten: true
          src: 'vendor-client/admin/aicons/fonts/*'
          dest: 'www/css/fonts/'
        ,
          expand: true
          flatten: true
          src: 'vendor-client/bootstrap/fonts/*'
          dest: 'www/fonts/'
        ]

  # These plugins provide necessary tasks
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  # Tasks
  grunt.registerTask 'default', [
    'less'
    'cssmin'
    'uglify'
    'copy'
  ]
