
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

function funcViewASetting()
{
    echo -e "Enter variable name: \c"
    read answer
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
  echo -e "\n Enter variable name: \c"
  read answer
  value=${DictionaryOfConfigures[$answer]}
  if [[ -z "$value" ]] ; then
    echo "Variable does not exits."
  else
    echo "$answer=$value"
    echo -e "\n Delete this setting (y/n)?: \c"
    read choice
    case $choice in
      Y|y)
          echo -e "\n Delete variable $answer"
          unset DictionaryOfConfigures[$answer]
          # echo ${DictionaryOfConfigures[@]}
          # echo ${!DictionaryOfConfigures[@]}
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
    flag=y
    while [ $flag = y ]
    do
        echo -e "\n Enter setting (format: ABCD=abcd): \c"
        read answer
		numberOfEqualSign=$(echo $answer | tr -cd '=' | wc -c)
		if [[ $numberOfEqualSign != 1 ]] ; then
			echo "Invalid setting"
		# elif [[ $numberOfEqualSign > 1 ]] ; then
			# echo "Invalid setting"
		else
			echo "Valid setting"
			
		fi
        # if [ $(expr index $answer '=' ) = 0 ] ; then
            # echo "Invalid setting"
        # else
            # echo "pa"
        # fi
		#$(expr index $stringZ '=')
        # if [[ ${expr index $answer '=' } = 0 ]] ; then
        # else
        # fi
        
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
# echo ${DictionaryOfConfigures[@]}
# echo ${!DictionaryOfConfigures[@]}
funcPrintDictionary

flag=y
while [ $flag = y ]
do
    echo -e "\n *** MENU ***"
    echo -e "\n 1. Add a Setting"
    echo -e "\n 2. Delete a Setting"
    echo -e "\n 3. View a Setting"
    echo -e "\n 4. View All Settings"
    echo -e "\n Q   – Quit"
    echo -e "\n CHOICE: \c"
    read answer
    case $answer in
        Q|q) echo "Quit program.";exit;;
          # 4) echo; cat config.txt ;;
          4) echo; funcPrintDictionary ;;
          3) echo; funcViewASetting ;;
          2) echo; funcDeleteASetting ;;
          1) echo; funcAddASetting ;;
          *) echo "Invalid option";;
    esac
done
