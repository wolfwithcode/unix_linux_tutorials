# My first shell script
# I'm a little excited ...
# echo The date today is 'date'
# echo The current directory is 'pwd'
# echo My home directory is
# cd
# pwd
# echo The current users are
# users
#echo "name of the shell script: $0"
#echo "the number of arguments: $#"
#echo "the first argument is: $1"
#echo "the second argument is: $2"
#echo "the third argument is: $3"
#echo "the complete set of arguments is: $*"

numberOfArguments=$#
echo "the number of arguments: $numberOfArguments"
if [ $numberOfArguments -eq 0 ]; then
 echo "empty argument"
 #numberOfFileC=$(ls -t *.c|wc -l)
 #numberOfFileC=$(ls|grep *.c|wc -l)
 numberOfFileC=$(find . -name '*.c'|wc -l)
 echo "number of file C $numberOfFileC"
 if [ $numberOfFileC -eq 0 ]; then
  echo "No C files found"
 else
  echo "Have C files"
  cFiles=$(ls *.c)
  #echo "cFiles $cFiles"
  listOfFileC=(${cFiles//\n/ })
  #while read -r cFile
  #  do
      #echo -e "Enter the pattern to search: \c"
      #echo $cFile
  #    listOfFileC+=($cFile)
      #echo $(cat $cFile | head -1)
      #echo -e "Delete file $cFile? (y/n):"
      #read userInput
      #echo "user input $userInput"
  #  done <<< $cFiles

  #echo $array
  inputUser=n
  for file in "${listOfFileC[@]}";do
    echo "Displaying first 10 lines of $file:"
    echo $(cat $file | head -10)
    echo -e "Delete file $file? (y/n): \c"
    read answer
    #echo $answer
    case $answer in
         Y|y) echo -e "File $file deleted.";;
         N|n) echo -e "File $file NOT deleted.";;
           *) echo "Invalid option";;
    esac
  done
  #echo -e "Enter the pattern to search: \c"
  #read pname
  #for cFile in "$cFiles"
  #echo "array $array"
  #for cFile in $array
  #do
  #  echo "It is the $cFile "
  #  echo $(cat $cFile | head -1)
    #echo "hello"
  #done
 fi
else
 #numberOfFileC=$(ls -t *.c|wc -l)
 echo "have arguments"
 #echo "number of file C ${numberOfFileC}"
 #echo "number of file C $numberOfFileC"
 #if [ $numberOfArguments -eq 0 ]; then
 # echo "No C files found"
 #else
 # echo "Have C files"
 #fi
fi
