FROM rocker/r-ver:4.2.2
# To run rstudio, change above to FROM rocker/rstudio:4.0.4

## Set a default user. Available via runtime flag `--user rserve`
## User should also have & own a home directory (for rstudio or linked volumes to work properly).
RUN useradd rserve \
	&& mkdir /home/rserve \
	&& chown rserve:rserve /home/rserve

RUN apt-get update && apt-get install -y \
	libglpk-dev \
	libxml2-dev

#### install libs
#### Keep up to date with RServe Dockerfile if doing eda development

### Rserve - note this is the official Rserve package, NOT our VEuPathDB Rserve repository
RUN R -e "install.packages('Rserve', version='1.8-9', repos='http://rforge.net')"

### BioConductor
RUN R -e "install.packages('BiocManager')"
RUN R -e "BiocManager::install('S4Vectors')"

### CRAN
RUN R -e "install.packages('ape')"
RUN R -e "install.packages('bit64')"
RUN R -e "install.packages('crayon')"
RUN R -e "install.packages('data.table')"
RUN R -e "install.packages('devtools')"
RUN R -e "install.packages('dotenv')"
RUN R -e "install.packages('jsonlite')"
RUN R -e "install.packages('lubridate')"
RUN R -e "install.packages('moments')"
RUN R -e "install.packages('phytools')"
RUN R -e "install.packages('Rcpp')"
RUN R -e "install.packages('readr')"
RUN R -e "install.packages('remotes')"
RUN R -e "install.packages('sloop')"
RUN R -e "install.packages('scales')"
RUN R -e "install.packages('vegan')"
RUN R -e "install.packages('zoo')"

# possibly for RStudio
EXPOSE 8787

WORKDIR /home/dev
RUN echo "source('.dev/setup.R')" >> /usr/local/lib/R/library/base/R/Rprofile
