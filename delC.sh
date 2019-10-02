function deleteAFile()
{
  file=$1
  #echo "delete file $file"
  echo "Displaying first 10 lines of $file:"
  cat $file | head -10
  echo -e "Delete file $file? (y/n): \c"
  read answer
  case $answer in
       Y|y) echo -e "File $file deleted.";;
       N|n) echo -e "File $file NOT deleted.";;
         *) echo "Invalid option";;
  esac
  return
}
numberOfArguments=$#
#echo "the number of arguments: $numberOfArguments"
echo "This script removes C files which you no longer want to keep."
echo "Here are the C file(s) under the current directory:"
if [ $numberOfArguments -eq 0 ]; then
 #echo "empty argument"
 numberOfFileC=$(find . -name '*.c'|wc -l)
 #echo "number of file C $numberOfFileC"
 if [ $numberOfFileC -eq 0 ]; then
  echo "No C files found."
 else
  #echo "Have C files"
  echo $(ls *.c)
  echo
  cFiles=$(ls *.c)
  #echo "cFiles $cFiles"
  listOfFileC=(${cFiles//\n/ })
  inputUser=n
  for file in "${listOfFileC[@]}"
  do
    deleteAFile $file
  done
 fi
else
  #echo "have arguments"
  #echo "the complete set of arguments is: $*"
  listOfFileC=("$@")
  echo "$@"
  for file in "${listOfFileC[@]}"
  do
    if [ -f $file ] ; then
        echo -e "\nFile $file exists"
        deleteAFile $file
    else
        echo -e "\nFile $file does not exist."
    fi
  done
fi
