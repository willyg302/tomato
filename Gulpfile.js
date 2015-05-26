var gulp       = require('gulp');
var jade       = require('gulp-jade');
var less       = require('gulp-less');
var minifycss  = require('gulp-minify-css');
var uglify     = require('gulp-uglify');

var browserify = require('browserify');
var coffeeify  = require('coffeeify');
var del        = require('del');
var buffer     = require('vinyl-buffer');
var vinyl      = require('vinyl-source-stream');


var paths = {
	assets: [
		'./app/img/**/*.*'
	],
	app: './app',
	dist: './dist',
	css: './app/less/main.less',
	js: './app/js/main.coffee',
	index: './app/jade/index.jade'
};

gulp.task('clean', function(cb) {
	del(paths.dist, cb);
});

gulp.task('copy-assets', function() {
	return gulp.src(paths.assets, {base: paths.app})
		.pipe(gulp.dest(paths.dist));
});

gulp.task('compile-css', function() {
	return gulp.src(paths.css)
		.pipe(less())
		.pipe(minifycss())
		.pipe(gulp.dest(paths.dist));
});

gulp.task('compile-js', function() {
	return browserify(paths.js)
		.transform(coffeeify)
		.bundle()
		.pipe(vinyl('main.js'))
		.pipe(buffer())
		.pipe(uglify())
		.pipe(gulp.dest(paths.dist));
});

gulp.task('compile-jade', function() {
	return gulp.src(paths.index)
		.pipe(jade())
		.pipe(gulp.dest(paths.dist));
});

gulp.task('default', ['clean'], function() {
	gulp.start('copy-assets', 'compile-css', 'compile-js', 'compile-jade');
});
