var gulp = require('gulp');
{{_cursor_}}

gulp.task('default', ['build']);

gulp.task('build', () => {
    return gulp.src(['src/**/*.js'])
        .pipe(gulp.dest('built'));
});
