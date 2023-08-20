#!/usr/bin/env bash
#发布仓库到CocoaPods

pod spec lint

pod trunk register flywithbug@gmail.com flywithbug  --verbose
#邮箱验证

#上传
pod trunk push FBRouter.podspec --allow-warnings