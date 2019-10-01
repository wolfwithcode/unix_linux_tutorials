numberOfArguments=$#
echo "the number of arguments: $numberOfArguments"
if [ $numberOfArguments -eq 0 ]; then
 echo "empty argument"
 numberOfFileC=$(find . -name '*.c'|wc -l)
 echo "number of file C $numberOfFileC"
 if [ $numberOfFileC -eq 0 ]; then
  echo "No C files found"
 else
  echo "Have C files"
  cFiles=$(ls *.c)
  #echo "cFiles $cFiles"
  listOfFileC=(${cFiles//\n/ })
  inputUser=n
  for file in "${listOfFileC[@]}"
  do
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
 fi
else
 echo "have arguments"
fi
