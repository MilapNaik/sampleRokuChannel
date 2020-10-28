

function echoUsage {
	echo "Commands:"
	echo "--pw - Password to Roku device"
	echo "--user - Username to Roku device"
	echo "--ip - IP address to Roku device"
}

while [ "$1" != "" ]; do
	case $1 in
		help )
			echoUsage
			exit 1
			;;
		--user )
			shift
			user=$1
			;;
		--pw )
			shift
			password=$1
			;;

		--ip )
			shift
			ip=$1
			;;

		* )
			echo "Invalid parameter provided"
			echoUsage
			exit 1
	esac
	shift
done

outDir=out
appName="sampleRokuChannel"
outFileNamePrefix=${outDir}/${appName}
echo "${outFileNamePrefix}"

userPass=$user:$password
# remove old app
if [ -e "${outFileNamePrefix}.zip" ]; then
	rm  ${outFileNamePrefix}.zip
fi
if [ ! -d ${outDir} ]; then
	mkdir -p ${outDir}
fi
if [ ! -w ${outDir} ]; then
	chmod 755 ${outDir}
fi

# create package
if [ -d ${sourceDir} ]; then
	zip -9 -r --exclude=*.DS_Store* ${outFileNamePrefix}.zip . -i components/\* -x dist/\*
	zip -0 -r --exclude=*.DS_Store* ${outFileNamePrefix}.zip . -i images/\* -x dist/\*
	zip -9 -r --exclude=*.DS_Store* ${outFileNamePrefix}.zip . -i manifest -x dist/\*
	zip -9 -r --exclude=*.DS_Store* ${outFileNamePrefix}.zip . -i source/\* -x dist/\*
fi

# Install
echo "Installing ${appName} to host ${ip}"
curl --user ${userPass} --digest -s -S \
		-F "mysubmit=Install" \
		-F "archive=@${outFileNamePrefix}.zip" \
		-F "passwd=" http://${ip}/plugin_install \
	| grep "<font color" | sed "s/<font color=\"red\">//" | sed "s[</font>[["