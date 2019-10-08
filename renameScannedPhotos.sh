folderPath=$1
title=$2
# for f in *\ *; do mv "$f" "${f// /_}"; done

echo "for f in $folderPath/*.*; do mv "$f" "${f// /_}"; done"
for f in $folderPath/*.*; do mv "$f" "${f// /_}"; done
# ls $folderPath $title
# files=$(ls $folderPath )
# listOfFiles=(${files//\n/ })
#for file in "${listOfFiles[@]}"
numberOfFile=$(ls -1 $folderPath/*.*| wc -l)
echo "numberOfFile $numberOfFile"
index=$numberOfFile
for file in $folderPath/*.*
do
  # echo "$file becomes $title $index"
  echo "cp $file $folderPath/${title}_${index}.jpg"
  mv $file $folderPath/${title}_${index}.jpg
  index=$((index - 1))
done
