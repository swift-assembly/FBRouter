# FBRouter
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/FBRouter.svg)](https://cocoapods.org/pods/FBRouter)
[![Build Status](https://github.com/swift-assembly/FBRouter/workflows/CI/badge.svg)](https://github.com/swift-assembly/FBRouter/actions)
[![CodeCov](https://img.shields.io/codecov/c/github/swift-assembly/FBRouter.svg)](https://codecov.io/gh/swift-assembly/FBRouter)

<!--
![registe](https://raw.githubusercontent.com/swift-assembly/FBRouter/master/Source/register.jpg)
-->





Usage
==============================
### Simple router regist
``` swift
	let urlMappings = ["home":"ListViewController",
					   "vc00":"ViewController",
					   "vc01":"ViewController01",
					   "vc02":"ViewController02",
					   "vc03":"ViewController03",
					   "vc04":"ViewController04"]
	FBRouter.router().registURLMapping(urlmappings: urlMappings)
```
