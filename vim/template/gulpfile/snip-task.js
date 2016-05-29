gulp.task('{{_cursor_}}', () => {
    return gulp.src(['src/**/*.js'])
        .pipe(gulp.dest('built'));
});
