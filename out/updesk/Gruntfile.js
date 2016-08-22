// Gruntfile.js

// our wrapper function (required by grunt and its plugins)
// all configuration goes inside this function
module.exports = function(grunt) {


  // ===========================================================================
  // LOAD GRUNT PLUGINS ========================================================
  // ===========================================================================
  // we can only load these if they are in our package.json
  // make sure you have run npm install so our app can find these
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-watch');
  
  
  // Gruntfile.js

grunt.initConfig({

  
    pkg: grunt.file.readJSON('package.json'),

  

    // compile less stylesheets to css -----------------------------------------
    less: {
      options: {
        banner: '/*\n <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> \n*/\n',
        cleancss:true
      },
      build: {
        files: {
            'src/css/upnew.min.css': 'src/less/upnew.less',
            'src/css/bootstrap.min.css': 'src/less/bootstrap/bootstrap.less',
        }
      }
    },
   
     // configure watch to auto update ----------------
    watch: {
      
      // for stylesheets, watch css and less files 
      // only run less and cssmin stylesheets: { 
      lesstocss:{
        files: ['src/less/upnew.less'], 
        tasks: ['less'] 
      }
        
    }

});


};

