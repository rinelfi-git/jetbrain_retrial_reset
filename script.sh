#!/bin/bash
# définitin des variables
operating_system=$(uname -s)
jetbrain_products=("PhpStorm" "WebStorm" "IntelliJIdea" "CLion" "GoLand" "PyCharm" "Rider" "DataGrip" "RubyMine" "AppCode")
config_directory=${HOME}"/.config/JetBrains"
java_directory=${HOME}"/.java/.userPrefs"
current_directory=${pdw}
if [ ${operating_system} == "Linux" ]; then
  if [ ! -e ${config_directory} ]; then
    echo "JetBain directory not found; make sure you have latest version of your jetbrain software"
    exit
  fi
  if [ ! -r ${config_directory} ] || [ ! -w ${config_directory} ]; then
    echo "You don't have the reading or writing privilege on this directory"
    exit
  fi
  for product in ${jetbrain_products[*]}
    do
    cd ${config_directory}
    directory=$(ls -d ${product}*)
    if [ -n ${directory} ] && [ -e ${directory} ]; then
      echo "==========================================="
      echo "             "${directory}
      echo "==========================================="
      echo "delete \"eval\" directory at: ${config_directory}/eval"
      cd ${directory}
      if [ -e eval ]; then
        rm -rf eval
      else
        echo "\"eval\" doesn't exist, nothing to delete... following"
      fi
      echo "backup \"options/other.xml\" at: ${config_directory}/options/other.xml"
      let "i=1"
      while [ -e options/other_${i}.xml ]; do
        let "i+=1"
      done
      if [ -e options/other.xml ]; then
        cp options/other.xml options/other_${i}.xml
        echo "delete \"options/other.xml\""
        rm options/other.xml
      else
        echo "\"other.xml\" doesn't exist, nothing to copy... following"
      fi
      cd ${java_directory}
      echo "Delete java global preference"
      if [ -e prefs.xml ]; then
        rm prefs.xml
      fi
      cd jetbrains
      if [ -e prefs.xml ]; then
        rm prefs.xml
      fi
      rm -rf ${product,,}
    fi
    cd ${current_directory}
  done
  echo -e "\n\n             CONGRATULATION!\n         YOUR LICENCE IS NOW RESET\n\n"
else
  echo "The operating system is not supported yet"
fi

