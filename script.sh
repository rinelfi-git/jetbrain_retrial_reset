#!/bin/bash
# variable initialization
operating_system=$(uname -s)
jetbrain_products=("PhpStorm" "WebStorm" "IntelliJIdea" "CLion" "GoLand" "PyCharm" "Rider" "DataGrip" "RubyMine" "AppCode")
config_directory=${HOME}"/.config/JetBrains"
java_directory=${HOME}"/.java/.userPrefs"
current_directory=$(pwd)
# check if the operating system is realy a linux
if [ ${operating_system} == "Linux" ]; then
# if the jetbrain directory doesn't exist, stop the script
  if [ ! -e ${config_directory} ]; then
    echo "JetBain directory not found; make sure you have latest version of your jetbrain software"
    exit
  fi
# if don't have the reading and writing privileges stop the script
  if [ ! -r ${config_directory} ] || [ ! -w ${config_directory} ]; then
    echo "You don't have the reading or writing privilege on this directory"
    exit
  fi
# loop for product list
  for product in ${jetbrain_products[*]}
    do
# change directory location (it is for some result visibility)
    cd ${config_directory}
    directory=""
# if the project directory doesn't exist, dump it
    if [ ! -z $(find -name ${product}*) ]; then
      directory=$(ls -d ${product}*)
    fi
# check if the product name directory is realy a "directory"
    if [ ! -z ${directory} ] && [ -d ${directory} ]; then
      echo "=============================================="
      echo "               \"${directory}\"                  "
      echo "=============================================="
      echo "delete \"eval\" directory at: ${config_directory}/eval"
# it will delete eval directory if it exists or dump it
      cd ${directory}
      if [ -e eval ]; then
        rm -rf eval
      else
        echo "\"eval\" doesn't exist, nothing to delete... following"
      fi
      echo "backup \"options/other.xml\" at: ${config_directory}/options/other.xml"
      let "i=1"
# it will rename the old existing "other.xml"
      while [ -e options/other_${i}.xml ]; do
        let "i+=1"
      done
# it will copy the old other.xml file then delete it if it exists or dump it
      if [ -e options/other.xml ]; then
        cp options/other.xml options/other_${i}.xml
        echo "delete \"options/other.xml\""
        rm options/other.xml
      else
        echo "\"other.xml\" doesn't exist, nothing to copy... following"
      fi
      cd ${java_directory}
      echo "Delete java global preference"
# it will delete the global java preference file if it exists or dump it
      if [ -e prefs.xml ]; then
        rm prefs.xml
      fi
      cd jetbrains
# it will delete the global java preference file for jetbrain if it exists or dump it
      if [ -e prefs.xml ]; then
        rm prefs.xml
      fi
# it will delete the product java preference if it exists
      rm -rf ${product,,}
    fi
# change location to the current directory for the next product
    cd ${current_directory}
  done
  echo -e "\n\n                CONGRATULATION!\n           YOUR LICENCE IS NOW RESET\n\n"
else
  echo "The operating system is not supported yet"
fi

