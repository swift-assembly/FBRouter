#!/usr/bin/env bash
#发布仓库到CocoaPods

pod spec lint

pod trunk register flywithbug@gmail.com  flywithbug --description=路由组件 

#上传
pod trunk push FBRouter.podspec --allow-warnings