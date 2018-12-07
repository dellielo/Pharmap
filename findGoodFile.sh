desiredPx=$2
current=0
lastFile="none"

for file in `ls $1`
do
    lastFile=$file
    nbLine=`cat $1$file | wc -l`
    new=$(($nbLine + $current))
    if (($new > $desiredPx))
    then
	echo "Line nb: "
	echo $(($desiredPx - $current))
	echo "file: "
	echo $lastFile
	break;
    fi
    current=$new
done
