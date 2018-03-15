var gulp = require('gulp');
var minifier = require('gulp-minifier');
var clean = require('gulp-clean');
var concat = require('gulp-concat');
var rename = require('gulp-rename');
var riot = require('gulp-riot');
var runSequence = require('run-sequence');

gulp.task('clean', function () {
    return gulp.src([
        '../public/css',
        '../public/js',
        '../public/tags',
    ], {
        read: false
    }).pipe(clean({
        force: true
    }));
});

gulp.task('critical-css', function () {
    return gulp.src([
            'node_modules/spectre.css/dist/spectre.min.css',            
            'css/app.css'
        ])
        .pipe(minifier({
            minify: true,
            minifyCSS: true,
            collapseWhitespace: true
        }))
        .pipe(concat('style.min.css'))
        .pipe(gulp.dest('../public/css'));
});

gulp.task('css', function () {
    return gulp.src([            
            'node_modules/spectre.css/dist/spectre-icons.min.css',
            'node_modules/sweetalert2/dist/sweetalert2.min.css',
            'node_modules/js-autocomplete/auto-complete.css',
            'node_modules/pell/dist/pell.min.css'            
        ])
        .pipe(minifier({
            minify: true,
            minifyCSS: true,
            collapseWhitespace: true
        }))
        .pipe(gulp.dest('../public/css'));
});

gulp.task('critical-js', function () {
    return gulp.src([
            'node_modules/riot/riot.min.js',   
            'js/geral.js'
        ])
        .pipe(minifier({
            minify: true,
            minifyJS: true,
            collapseWhitespace: true
        }))
        .pipe(concat('scripts.min.js'))
        .pipe(gulp.dest('../public/js'));
});

gulp.task('js', function () {
    return gulp.src([            
            'node_modules/sweetalert2/dist/sweetalert2.min.js',
            'node_modules/js-autocomplete/auto-complete.min.js',   
            'node_modules/pell/dist/pell.js'            
        ])
        .pipe(minifier({
            minify: true,
            minifyJS: true,
            collapseWhitespace: true
        }))        
        .pipe(gulp.dest('../public/js'));
});

gulp.task('tags', function () {
    return gulp.src([
            'tags/**'
        ])
        .pipe(riot({
            compact: true
        }))
        .pipe(gulp.dest('../public/tags'));
});

gulp.task('default', function () {
    runSequence('clean', ['critical-css', 'css', 'critical-js', 'js', 'tags']);
});