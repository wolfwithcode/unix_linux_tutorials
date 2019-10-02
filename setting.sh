declare -A DictionaryOfConfigures
filename='config.txt'
while read line;do
    array=(${line//=\ })
    key=${array[0]}
    value=${array[1]}
    DictionaryOfConfigures[$key]=$value
done < $filename
echo ${DictionaryOfConfigures[@]}
echo ${!DictionaryOfConfigures[@]}

continue=y
while [ $continue = y ]
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
          4) echo; cat config.txt;;
          *) echo "Invalid option";;
    esac
done
