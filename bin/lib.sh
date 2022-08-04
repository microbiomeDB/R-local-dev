#!/bin/bash

R_REPOSITORIES=( \
  veupathUtils \
  plot.data \
  microbiomeComputations \
  Rserve \
)

JAVA_PROJECTS=( EdaCommon ${JAVA_SERVICE_PROJECTS[*]} )
ALL_PROJECTS=( ${JAVA_PROJECTS[*]} Rserve )

function configure {
  [ -f .env.local ] || (echo "Initializing .env.local to sample file." && cp .env.local.sample .env.local)
  [ "$EDITOR" == "" ] && EDITOR='/usr/bin/vi'
  $EDITOR .env.local
}

function doProjectsOperation {
  projectArrayName=$1[@]
  projects=("${!projectArrayName}")
  cmd=$2
  cd projects
  for project in "${projects[@]}"; do
    if [ -e $project ]; then
      cd $project
      echo "${project}: $cmd"
      $cmd
      cd ..
    fi
  done
  cd ..
}

function doJavaProjectsOperation {
  doProjectsOperation JAVA_PROJECTS "$@"
}

# Also maybe a regular docker build?
function install {
  checkoutAll
}

function checkoutAll {
  cd projects
  for project in "${R_REPOSITORIES[@]}"; do
    git clone git@github.com:VEuPathDB/${project}.git
  done
  cd ..
}

function updateAll {
  doProjectsOperation R_REPOSITORIES "git pull"
}


function runDocker {
  source .env.local
  source .env
  cd projects/EdaDataService
  docker-compose -f docker-compose.yml -f docker-compose.yml.local up --build
}

function buildRserve {
  cd projects/Rserve
  docker build -t rserve . --no-cache
  cd ../..
}

function startRserve {
  source .env.local
  source .env
  docker="docker run -p ${RSERVE_SERVER_PORT}:6311 --rm rserve:latest"
  echo "$docker"
  read -s -p "Password: " PW
  echo
  echo $PW | sudo -S $docker &> logs/Rserve.log &
}

function stopRserve {
  docker ps | grep rserve | awk '{ print $1 }' | xargs docker stop
}

if [ "$#" -ge 2 ]; then
  echo "USAGE: lib.sh [command]"
elif [ "$#" -eq 1 ]; then
  $1
fi