# FBRouter
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/FBRouter.svg)](https://cocoapods.org/pods/FBRouter)
[![Build Status](https://github.com/swift-assembly/FBRouter/workflows/CI/badge.svg)](https://github.com/swift-assembly/FBRouter/actions)
[![CodeCov](https://img.shields.io/codecov/c/github/swift-assembly/FBRouter.svg)](https://codecov.io/gh/swift-assembly/FBRouter)

<!--
![registe](https://raw.githubusercontent.com/swift-assembly/FBRouter/master/Source/register.jpg)
-->
<!-- ![demo_gif](https://raw.githubusercontent.com/swift-assembly/FBRouter/master/Source/RPReplay_Final1590321909.gif) -->

<!-- align=center -->
<div align=left ><img width="300" src="https://raw.githubusercontent.com/swift-assembly/FBRouter/master/Source/RPReplay_Final1590321909.gif"/></div>

安装
==============
### CocoaPods

1. 在 Podfile 中添加 `pod 'FBRouter'`。
2. 执行 `pod install` 或 `pod update`。
3. 导入 import FBRouter。




API 
=============================
### regist routerhHost 注册路由组件的host
```
public func registURLMapping(urlmappings:Dictionary<String,String>)
public static func registURLMapping(urlmappings:Dictionary<String,String>)
```


### set scheme  appScheme 注册应用的scheme 
```
	public static func setScheme(scheme: String) 
	public func setScheme(scheme: String) 

```

### set wrapNavClass 
```
public static func setWrapNavgClass(className: AnyClass)
```


### FBURLAction
```
//init 
	public convenience init(url:URL)
public convenience init(urlString:String)    
public convenience init(host:String)
public convenience init(httpUrl:String?)


// set params
public func setInteger(_ key:String, value:NSInteger) 

public func setInt(_ key:String, value:Int)  }
public func setDouble(_ key:String, value:Double)  
public func setString(_ key:String, value:String)
public func setBool(_ key:String, value:Bool)
public func setAny(_ key:String, value:Any) 
public func addEntriesFromDictonary(entries:Dictionary<String, Any>)
public func addParamsFromURLAction(urlAction:FBURLAction)

// query param
public func integer(_ key:String) -> NSInteger? 
public func int(_ key:String) -> Int? 
public func double(_ key:String) -> Double?
public func string(_ key:String) -> String? 
public func bool(_ key:String) -> Bool?
public func anyObject(_ key:String) -> Any?

```

### UIViewController Extension
```
@discardableResult
func openURLAction(_ urlAction:FBURLAction) -> UIViewController? 

@discardableResult
func openHostString(host:String) -> UIViewController? 

@discardableResult
func openURL(url:URL) -> UIViewController? 

@discardableResult
func openURLString(urlString:String) -> UIViewController? 

@discardableResult
func openHttpURLString(httpUrl:String) -> UIViewController?

```

### FBRouter Method
```
@discardableResult
public func openURL(url:URL,from:UIViewController) -> UIViewController? {
    return openURLAction(FBURLAction.init(url: url), from: from)
}

@discardableResult
public func openURLString(urlString:String,from:UIViewController) -> UIViewController? {
    return openURLAction(FBURLAction.init(urlString: urlString), from: from)
}
@discardableResult
public func openHttpURLString(httpUrl:String,from:UIViewController) -> UIViewController? {
    return openURLAction(FBURLAction.init(httpUrl: httpUrl), from: from)
}

@discardableResult
public func openHost(host:String,from:UIViewController) -> UIViewController? {
    return openURLAction(FBURLAction.init(host: host),from: from)
}

@discardableResult
public func openHost(host:String) -> UIViewController? {
    return openURLAction(FBURLAction.init(host: host))
}

@discardableResult
public func openURL(url:URL) -> UIViewController? {
    return openURLAction(FBURLAction.init(url: url))
}

@discardableResult
public func openURLString(urlString:String) -> UIViewController? {
    return openURLAction(FBURLAction.init(urlString: urlString))
}

@discardableResult
public func openHttpURLString(httpUrl:String) -> UIViewController? {
    return openURLAction(FBURLAction.init(httpUrl: httpUrl))
}

@discardableResult
public static func openURLAction(_ urlAction:FBURLAction) -> UIViewController? {
    return FBRouter.router().openURLAction(urlAction)
}

@discardableResult
public static func openURLAction(_ urlAction:FBURLAction,from:UIViewController?) -> UIViewController? {
    return FBRouter.router().openURLAction(urlAction,from: from)
}


@discardableResult
public static func openURL(url:URL,from:UIViewController) -> UIViewController? {
    return openURLAction(FBURLAction.init(url: url), from: from)
}

@discardableResult
public static func openURLString(urlString:String,from:UIViewController) -> UIViewController? {
    return openURLAction(FBURLAction.init(urlString: urlString), from: from)
}

@discardableResult
public static func openHttpURLString(httpUrl:String,from:UIViewController) -> UIViewController? {
    return openURLAction(FBURLAction.init(httpUrl: httpUrl), from: from)
}

@discardableResult
public static func openHost(host:String,from:UIViewController) -> UIViewController? {
    return openURLAction(FBURLAction.init(host: host),from: from)
}

@discardableResult
public static func openHost(host:String) -> UIViewController? {
    return openURLAction(FBURLAction.init(host: host))
}

@discardableResult
public static func openURL(url:URL) -> UIViewController? {
    return openURLAction(FBURLAction.init(url: url))
}

@discardableResult
public static func openURLString(urlString:String) -> UIViewController? {
    return openURLAction(FBURLAction.init(urlString: urlString))
}

@discardableResult
public static func openHttpURLString(httpUrl:String) -> UIViewController? {
    return openURLAction(FBURLAction.init(httpUrl: httpUrl))
}
```

### FBRouterDelegate 
```
func shouldOpenURLAction(_ urlAction:FBURLAction) -> Bool
func willOpenExternal(_ urlAction:FBURLAction) -> Bool
func didOpenExternal(_ urlAction:FBURLAction,success:Bool)
func willOpenURLAction(_ urlAction:FBURLAction)
func onMatchUnhandledURLAction(_ urlAction:FBURLAction)
func onMatchViewController(_ controller:UIViewController,urlAction:FBURLAction)
func openExternal(_ urlAction:FBURLAction, completionHandler completion: ((Bool) -> Void)?)
func handleLoginAction(_ urlAction:FBURLAction,controller:UIViewController) -> Bool

```



Usage
==============================
### delegate & register 
```
///
class AppDelegate: UIResponder, UIApplicationDelegate,FBRouterDelegate{
	.....
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		//delegate
		FBRouter.router().deleage = self
		registerURLMappings()
	}
	
}

func registerURLMappings() {
	let urlMappings = ["home":"ListViewController",
					   "vc00":"ViewController",
					   "vc01":"ViewController01",
					   "vc02":"ViewController02",
					   "vc03":"ViewController03",
					   "vc04":"ViewController04",
					   "vc05":"ViewController05",
					   "demo":"ViewControllerDemo"]
    FBRouter.router().registURLMapping(urlmappings: urlMappings)
	FBRouter.router().wrapNavgClass = BaseNavigationController.self as UINavigationController.Type
}


//FBRouterDelegate
func shouldOpenURLAction(_ urlAction: FBURLAction) -> Bool {
	return true
}

func willOpenExternal(_ urlAction: FBURLAction) -> Bool {
	return true
}

func didOpenExternal(_ urlAction: FBURLAction, success: Bool) {
	
}

func willOpenURLAction(_ urlAction: FBURLAction) {
	
}

func onMatchUnhandledURLAction(_ urlAction: FBURLAction) {
	
}

func onMatchViewController(_ controller: UIViewController, urlAction: FBURLAction) {
	
}

func openExternal(_ urlAction: FBURLAction, completionHandler completion: ((Bool) -> Void)?) {
	UIApplication.shared.open(urlAction.url!, options: [:], completionHandler:{
        (success) in
        guard let complete = urlAction.completeBlock else{
            return
        }
        complete(success)
    })
}

func handleLoginAction(_ urlAction: FBURLAction, controller: UIViewController) -> Bool {
	return true
}




```


###  router regist
``` 
let urlMappings = ["home":"ListViewController",
				   "vc00":"ViewController",
				   "vc01":"ViewController01",
				   "vc02":"ViewController02",
				   "vc03":"ViewController03",
				   "vc04":"ViewController04",
				   "vc05":"ViewController05",
				   "demo":"ViewControllerDemo"]
FBRouter.router().registURLMapping(urlmappings: urlMappings)
FBRouter.router().wrapNavgClass = BaseNavigationController.self as UINavigationController.Type
```









### push 
```
//use FBURLAction transform data
let urlAction = FBURLAction.init(host: "vc01?a=b")
urlAction.completeBlock = {
	(succes) in
	print("succes:",urlAction.url!)
}
urlAction.isSingleton = true
urlAction.setBool("Bool", value: true)
urlAction.setString("String", value: "String")
urlAction.setDouble("Double", value: 2.0202)
urlAction.setInteger("Integer", value: 101)
let person:Person = Person.init()
person.age = 18
person.name = "nini"
urlAction.setAny("person", value: person)
FBRouter.router().openURLAction(urlAction,from: self)

-----------------
//use UIViewController Extension

let urlAction = FBURLAction.init(host: "vc02?a=b")
urlAction.completeBlock = {
	(succes) in
	print("succes:",urlAction.url!)
}
openURLAction(urlAction)

```


系统要求
==============
swift 5.0
该项目最低支持 `iOS 10.0` 和 `Xcode 11.0`。



许可证
==============
FBRouter 使用 MIT 许可证，详情见 LICENSE 文件。

