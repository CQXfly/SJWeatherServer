#!/bin/sh

#echo "$1 $2"
if [ $1 ]
then
	if [ $1 = "run" ] 
	then
		if [ $2 ]
		then
			if [ $2 = "dev" ] 
			then
				echo "Running the development environment ..."
				sudo vapor run --env=development
			elif [ $2 = "pro" ] 
			then
				echo "Running in a production environment ..."
				sudo vapor run --env=production
			fi
		else
			echo "Running the development environment ..."
			vapor build && sudo vapor run --env=development
		fi
	elif [ $1 = "build" ]
	then
		echo "Running in build ..."
		vapor build
	elif [ $1 = "xcode" ]
	then
		echo "Running in generated Xcode project ..."
		vapor xcode
	fi
else

echo "You should use: 
	./run.sh run 
	./run.sh run dev
	./run.sh run pro
	./run.sh run build
	./run.sh run xcode "
fi
