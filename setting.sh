
function funcCheckFileExits() {
  file=$1
  if [ -f $file ] ; then
      echo -e "\n File $file exits."
  else
      echo -e "File $file is not exit."
      echo -e "Kindly create config.txt"
      exit 0
  fi
}

function funcPrintDictionary() {
  echo "Print file config.txt"
  for key in "${!DictionaryOfConfigures[@]}"; do
    echo "$key=${DictionaryOfConfigures[$key]}"
  done
}

function funcWriteDictionaryToFile() {
  echo "Write to file config.txt"
  echo -n > config.txt
  for key in "${!DictionaryOfConfigures[@]}"; do
    echo "$key=${DictionaryOfConfigures[$key]}" >> config.txt
  done
}

function funcViewASetting()
{
    # echo -e "Enter variable name: \c"
    # read answer
    read -p "Enter variable name: " answer
    value=${DictionaryOfConfigures[$answer]}
    if [[ -z "$value" ]] ; then
        echo "Variable does not exits."
    else
        echo "$answer=$value"
        echo "Requested setting displayed above."
    fi
}

function  funcDeleteASetting()
{
  # echo -e "\n Enter variable name: \c"
  # read answer
  read -p "Enter variable name: " answer
  value=${DictionaryOfConfigures[$answer]}
  if [[ -z "$value" ]] ; then
    echo "Variable does not exits."
  else
    echo "$answer=$value"
    # echo -e "\n Delete this setting (y/n)?: \c"
    # read choice
    read -p "Delete this setting (y/n)?: " choice
    case $choice in
      Y|y)
          echo -e "\n Delete variable $answer"
          unset DictionaryOfConfigures[$answer]
          funcPrintDictionary
          ;;
      N|n)
          echo -e "\n Do not delete variable $answer"
          ;;
        *)
          echo "Invalid option"
          ;;
    esac
  fi
  return
}

function  funcAddASetting()
{
    while true
    do
        # echo -e "\n Enter setting (format: ABCD=abcd): \c"
        # read answer
        read -p "Enter setting (format: ABCD=abcd): "  answer
        numberOfEqualSign=$(echo $answer | tr -cd '=' | wc -c)
        if [[ -z $answer ]] ; then
            echo "New setting not entered";
        elif [[ $numberOfEqualSign != 1 ]] ; then
            echo "Invalid setting"
        else
            # echo "Valid setting"
            numberOfSpace=$(echo $answer | tr -cd " " | wc -c)
            if [[ $numberOfSpace > 1 ]]; then
                echo "Invalid valid. Space is not allowed !"
            elif [ ${answer:0:1} = '=' ] ; then
                echo "The variable name of the setting is: "
                echo "The variable value of the setting is: $(echo $answer | tr -d '=')"
                echo "Invalid valid 1"
            elif [ ${answer:(-1)} = '=' ] ; then
                echo "The variable name of the setting is: $(echo $answer | tr -d '=')"
                echo "The variable value of the setting is: "
                echo "Invalid valid 2"
            else
                array=(${answer//=/ })
                key=${array[0]}
				        oldValue=${DictionaryOfConfigures[$key]}
                value=${array[1]}
                echo "The variableconfig.txt name of the setting is: $key "
                echo "The variable value of the setting is: $value "
				        if [[ -n "$oldValue" ]] ; then
					             echo "Variable exists. Changing the values of existing variables is not allowed."
                       break
                elif [[ ${answer:0:1} == [0-9] ]]; then
                    echo "Invalid setting. The first character of a variable name cannot be a digit."
                else
					          DictionaryOfConfigures[$key]=$value
                    break
                fi

            fi

        fi
    done
    return
}

filename='config.txt'
funcCheckFileExits $filename
declare -A DictionaryOfConfigures
while read line;do
    array=(${line//=/ })
    key=${array[0]}
    value=${array[1]}
    DictionaryOfConfigures[$key]=$value
done < $filename

funcPrintDictionary

while true
do
    echo -e "\n *** MENU ***"
    echo -e "\n 1. Add a Setting"
    echo -e "\n 2. Delete a Setting"
    echo -e "\n 3. View a Setting"
    echo -e "\n 4. View All Settings"
    echo -e "\n Q – Quit"
    # echo -e "\n CHOICE: \c"config.txt
    # read answer
    read -p "CHOICE: " CHOICE
    # case $answer in
    case $CHOICE in
        Q|q) echo "Quit program."; funcWriteDictionaryToFile ;exit;;
          4) echo; funcPrintDictionary ;;
          3) echo; funcViewASetting ;;
          2) echo; funcDeleteASetting ;;involvement
          1) echo; funcAddASetting ;;
          *) echo "Invalid option"; funcWriteDictionaryToFile ;;
    esac
done
