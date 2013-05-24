all:
	browserify -t coffeeify lib/lib.coffee > public/scripts/bundle.js
	coffee bin/compileProblems.coffee
