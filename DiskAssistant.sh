

if [ $1 ]
then
	if [ $1 = "show" ]
	then
		defaults write com.apple.finder AppleShowAllFiles Yes && killall Finder
	elif [ $1 = "hidden" ]
	then
		defaults write com.apple.finder AppleShowAllFiles No && killall Finder
	fi
else
echo "Please use the:
	show 		显示隐藏文件
	hidden		隐藏隐藏文件
	"
fi