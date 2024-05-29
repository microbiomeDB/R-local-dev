# R-local-dev

Container for local development of all things R in MicrobiomeDB.

<br>

# Quick start - work on one MicrobiomeDB R Package
Let's say we wanted to work on the [plot.data](https://github.com/microbiomeDB/MicrobiomeDB) package.
1. Run `make build` to build the docker image that contains all packages necessary for development.
2. Run `make start-shell` to start an interactive R session within the development container. R should start automatically and the output should end with something like the following
```
Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

>
```
3. Now we're ready to load and/or install MicrobiomeDB packages. If we want to work on the main package, MicrobiomeDB, for example run `load_all([path-to-MicrobiomeDB])`. You may first need to load any dependencies you haven't chosen to install in the Dockerfile.
4. Make changes to the package, reload changes with `load_all('MicrobiomeDB')` (or other package nameor location).
5. Once you're happy with the changes, run all the testthat changes using `devtools::test('MicrobiomeDB')`. Alternatively, run all the tests in one file using `test_file`.
6. All done? Quit using `quit()`.

NOTE: Keep in mind that you still need to make a PR against the package you're developing and once GitHub Actions are passing ask for a review.
