# !/usr/bin/env bash



if [ "$1" = "d" ]
	then
		derivedPath=$HOME"/Library/Developer/Xcode/DerivedData"
		echo $derivedPath
		rm -rf $derivedPath
fi


pod repo update flywithbug

if [ "$1"  = "clean" ]
then 
	rm -rf *.xcworkspace
	rm -rf *.xcodeproj/xcuserdata
	rm -rf Pods/
    rm -rf Podfile.lock
fi

pod install --verbose --no-repo-update


# #图片自动化生成
# path=$(dirname $(dirname "$PWD"))
# # echo $path
# cd  "$path""/JYMopedImageAssets"
# # current_path="$PWD"  # 同 "`pwd`"
# # echo $current_path
# sh run.sh
