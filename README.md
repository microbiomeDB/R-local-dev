# R-local-dev

Package for local development of all things R in VEuPathDB.

<br>

# Quick start - work on one VEuPathDB R Package
Let's say we wanted to work on the [plot.data](https://github.com/VEuPathDB/plot.data) package.
1. Run `make build` to build the docker image that contains all packages necessary for development.
2. Run `make start-shell` to start an interactive R session within the development container. R should start automatically and the output should end with something like the following
```
Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

>
```
3. Now we're ready to load and/or install VEuPathDB packages using `loadDevPackages`. If we want to work on plot.data, for example, run `loadDevPackages('plot.data')`. 
4. Make changes to the package, reload changes with `load_all('plot.data')` (or other package name).
5. Once you're happy with the changes, run all the test_that changes using `devtools::test('plot.data')`. Alternatively, run all the tests in one file (for example 'test-line.R') using `testFile('plot.data', 'test-line.R')`.
6. All done? Quit using `quit()`.

