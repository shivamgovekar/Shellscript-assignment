#!/bin/bash

echo  "Enter Component (INGESTOR/JOINER/WRANGLER/VALIDATOR)"
read first
if [[ $first == "INGESTOR" || $first == "JOINER" || $first == "WRANGLER" || $first == "VALIDATOR" ]]
	then
        echo "Component:" $first
else
	echo "Enter valid input"
	exit
fi

echo "Enter Scale (LOW/MID/HIGH)"
read second
if  [[ $second == "LOW" || $second == "MID" || $second == "HIGH"  ]]
	then
        echo "Scale:" $second
else
    echo "Enter valid input"
	exit
fi

echo "Choose between AUCTION and BID"
read third
if  [[ $third == "BID" || $third == "AUCTION"  ]] 
	then
		echo "You have chosen to "$third
else
    echo "Enter valid input"
	exit
fi

if [[ $third == "BID" ]]
	then
		third="vdopiasample-bid"
else
	third="vdopiasample"
fi


echo "Enter count (0-9)"
read fourth
if  [[ "$fourth" == [1-9] ]] 
	then
       	echo "Count is:" $fourth
	
else
    echo "Please enter valid input"
	exit
fi


> replace


error=0
for line in $(cat sig.conf) 
	do
		if [[ $(echo $line | awk -F';' '{print $1}') == "$third" && $(echo $line | awk -F';' '{print $3}') == "$first" ]]
			then
	       		echo "$line" | sed  "s/[0-9]/$fourth/g; s/LOW/$second/g; s/MID/$second/g; s/HIGH/$second/g" >> replace
				error=1
		else 
			echo "$line" >> replace
		fi	
    done

if [[ $error == 0 ]]
	then
		echo "Incorrect Input"
		exit
fi


mv replace sig.conf