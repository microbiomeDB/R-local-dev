### Functions that help to set up the environment

veupathdbPackages <- c('plot.data','veupathUtils','microbiomeComputations')

# Properly load VEuPathDB packages for development
# packagesToDevelop must be a subset of ['plot.data','veupathUtils','microbiomeComputations']
# All other VEuPathDB packages not in packagesToDevelop will be installed from github
# Example use: loadDevPackages('plot.data')
loadDevPackages <- function(packagesToDevelop = veupathdbPackages) {

  if (!(packagesToDevelop %in% veupathdbPackages)) {
    stop(paste('packagesToDevelop must be a subset of ', veupathdbPackages))
  }

  # Load packages

  # TODO all this does currently is set a time zone. 
  # should do that generally maybe, rather than only for plot.data 
  # the .env file should be in this repo
  if ('plot.data' %in% packagesToDevelop) {
    # Handle plot.data environment 
    library(dotenv)
    load_dot_env(file="plot.data/.dev/.env")
  }

  # Load the packages (in order). If we're not developing a package, install it
  if ('veupathUtils' %in% packagesToDevelop){
    devtools::load_all('veupathUtils') 
  } else {
    remotes::install_github('VEuPathDB/veupathUtils')
  }

  if ('plot.data' %in% packagesToDevelop) {
    devtools::load_all('plot.data')
  } else {
    remotes::install_github('VEuPathDB/plot.data')
  }

  if ('microbiomeComputations' %in% packagesToDevelop) {
    devtools::load_all('microbiomeComputations')
  } else {
    remotes::install_github('VEuPathDB/microbiomeComputations')
  }

  # Print some useful info
  successMessage <- paste0(
    "\n\n\n\nSuccessfully loaded the following packages:\n\n\t"
    , packagesToDevelop
    , "\n\nAll other VEuPathDB packages were installed using the latest version on github. \n \n"
    , "After making any changes to the code, reload the package using\n\t"
    , "load_all(", packagesToDevelop[1], ")\n\n"
    , "Test changes by running a specific test file with\n\t"
    , "testFile(", packagesToDevelop[1], "testFileName)\n\n"
    , "or by running all tests with\n\t"
    , "devtools::test(", packagesToDevelop[1], ")\n"
  )

  cat(successMessage)

}


## Run all tests in one file
# Usually we can do this using devtools::test_file() but it requires
# us to do a lot of directory changing. The testFile function below
# handles the directory changing for us.
# NOTE: this function assumes the packages have the standard testthat
# directory structure: package/tests/testthat/test-file.R
# package = string, name of package
# file = string, name of test file
# Example run: testFile('plot.data', 'test-line.R')
testFile <- function(package, file) {
  
  # Set the working directory to the package
  setwd(package)
  cat(paste0('Working directory set to ', getwd(), '\n'))

  # Run the test file
  devtools::test_file(paste0('tests/testthat/',file))

  # Return to the top level
  setwd('..')
  cat(paste0('\nWorking directory returned to ', getwd(), '\n'))
}
