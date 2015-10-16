// Generated by CoffeeScript 1.10.0
var autoprefixer, browserify, compass, concat, filter, gulp, imagemin, minifyCss, paths, reactify, sourcemaps, styledown, svg2png, svgSprite, uglify;

gulp = require("gulp");

compass = require("gulp-compass");

autoprefixer = require("gulp-autoprefixer");

minifyCss = require('gulp-minify-css');

concat = require("gulp-concat");

uglify = require("gulp-uglify");

sourcemaps = require('gulp-sourcemaps');

reactify = require("reactify");

browserify = require("gulp-browserify");

imagemin = require('gulp-imagemin');

filter = require('gulp-filter');

svgSprite = require("gulp-svg-sprites");

svg2png = require('gulp-svg2png');

styledown = require("gulp-styledown");

paths = {
  cssSource: "source/css",
  cssDist: "public/css"
};

gulp.task("css", function() {
  return gulp.src(paths.cssSource + "/**/*.scss").pipe(compass({
    config_file: "./config.rb",
    css: paths.cssSource,
    sass: paths.cssSource
  })).pipe(autoprefixer({
    browsers: ["last 6 version", "> 1%", "ie 8", "Opera 12.1"]
  })).pipe(minifyCss({
    compatibility: 'ie8'
  })).pipe(gulp.dest(paths.cssDist));
});

gulp.task("js", function() {
  return gulp.src("source/js/app.js").pipe(browserify({
    transform: reactify
  })).pipe(concat("app.js")).pipe(uglify()).pipe(gulp.dest("./public/js"));
});

gulp.task("img", function() {
  return gulp.src('source/image/**/*').pipe(imagemin({
    progressive: true
  })).pipe(gulp.dest('public/image'));
});

gulp.task('sprites', function() {
  return gulp.src('source/image/svg/*.svg').pipe(svgSprite({
    cssFile: "css/sprite.css",
    padding: 1
  })).pipe(gulp.dest("source/image/svg/sprite")).pipe(filter("**/*.svg")).pipe(svg2png()).pipe(gulp.dest("source/image/svg/sprite"));
});

gulp.task("cssdoc", function() {
  return gulp.src('source/css/**/*.scss').pipe(styledown({
    config: './cssDOC/styledown.md',
    filename: 'zeo-css-doc.html'
  })).pipe(gulp.dest('./cssDOC/'));
});

gulp.task("watch", function() {
  gulp.watch("source/css/**/*.scss", ["css"]);
  gulp.watch("source/js/**/*.js", ["js"]);
  return gulp.watch("source/image/**/*", ["img"]);
});

gulp.task("default", ["css", "js", "img"]);

gulp.task("w", ["css", "js", "watch"]);
