//
//  FBBaseRouter.swift
//  Example
//
//  Created by Ori on 2020/5/17.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit


public class FBBaseRouter:NSObject {
 
    
	var scheme:String
	var urlMappings:Dictionary<String,FBURLTarget>
    var urlActionWaitingList:Array<FBURLAction>
	var lock:NSLock
	var animating: Bool
	
	var mainNavigationContontroller:UINavigationController?
	
	public override init() {
		self.animating = false
		self.scheme = "fb"
		self.urlMappings = Dictionary.init()
        self.urlActionWaitingList = Array.init()
		self.lock = NSLock.init()
	}
	
	func setMainNavigationController(navigationController:UINavigationController)  {
		self.mainNavigationContontroller = navigationController
	}
	
	func setScheme(scheme:String)  {
		self.scheme = scheme
	}
	func registURLMapping(urlmappings:Dictionary<String,String>)  {
		self.lock.lock()
		for item in urlmappings{
			self.urlMappings[item.key] = FBURLTarget.init(key: item.key, target: item.value)
		}
		self.lock.unlock()
	}
	@discardableResult
    func matchTargetWithURLAction(urlAction:FBURLAction) -> FBURLTarget? {
        guard let host = urlAction.url?.host  else{
            return nil
        }
        return self.urlMappings[host]
    }
    
    
	@discardableResult
	func obtainTargetControllerCheckURLAction(urlAction:FBURLAction) -> UIViewController? {
        guard let targetClass = urlAction.urlTarget?.targetClass as? UIViewController.Type else {
            return nil
        }
        var isSingleton = urlAction.isSingleton
        if targetClass.isSingleton() {
            isSingleton = true
        }
        if isSingleton {
            return self.mainNavigationContontroller?.viewControllers.fb_match(
                validate: { (item:UIViewController) -> Bool in
                return item.isKind(of: targetClass)})
        }
        return targetClass.init()
	}
    
    
	@discardableResult
	public func openURLAction(urlAction:FBURLAction) -> UIViewController? {
        var success :Bool = false
        
        defer {
            self.callBack(urlAction: urlAction, success: success)
        }
        
        if self.shouldOpenURLAction(urlAction: urlAction) == false{
            return nil
        }
        if urlAction.openExternal || urlAction.url?.scheme != self.scheme{
            if self.willOpenExternal(urlAction: urlAction) {
               self.openExternal(urlAction: urlAction)
            }
            return nil
        }
        urlAction.urlTarget = self.matchTargetWithURLAction(urlAction: urlAction)
        guard urlAction.urlTarget != nil else{
            self.onMatchUnhandledURLAction(urlAction: urlAction)
            return nil
        }
        
        
		return nil
	}
    
    
    

// MARK: -Methods
    /// 打开之前判断是否可以打开
    /// - Parameter urlAction: urlAction description
    func shouldOpenURLAction(urlAction:FBURLAction) -> Bool {
        
        return true
    }
    
    
    /// 将要打开外链
    /// - Parameter urlAction: urlAction description
    func willOpenExternal(urlAction:FBURLAction)->Bool {
        return true
    }
    
    /// 将要打开
    /// - Parameter urlAction: urlAction description
    func willOpenURLAction(urlAction:FBURLAction)  {
        
    }
    
    /// 匹配到不能打开的的URLAction,抛出
    /// - Parameter urlAction: urlAction description
    func onMatchUnhandledURLAction(urlAction:FBURLAction) {
        
    }
    
    func openExternal(urlAction:FBURLAction) {
        
        UIApplication.shared.open(urlAction.url!, options: [:], completionHandler:{
            (success) in
            guard let complete = urlAction.completeBlock else{
                return
            }
            complete(success)
        })
    }
    
    func handleLoginAction(urlAction:FBURLAction,controller:UIViewController) -> Bool {
        
        return false
    }
    
    
    func callBack(urlAction:FBURLAction,success:Bool) {
        guard let complete = urlAction.completeBlock else{
            return
        }
        complete(success)
    }
}




//
//extension UIViewController {
//
//	private class var sharedApplication: UIApplication? {
//	  let selector = NSSelectorFromString("sharedApplication")
//	  return UIApplication.perform(selector)?.takeUnretainedValue() as? UIApplication
//	}
//
//	open class var topController:UIViewController?{
//		guard let currentWindows = self.sharedApplication?.windows else {
//			return nil
//		}
//		var rootVC:UIViewController?
//		for window in currentWindows {
//			if let windowRootVC = window.rootViewController, window.isKeyWindow{
//				rootVC = windowRootVC
//				break
//			}
//		}
//		return self.autoGetTopController(of: rootVC)
//	}
//
//	open class  func autoGetTopController(of ViewController:UIViewController?) -> UIViewController? {
//		if let presentedVC = ViewController?.presentedViewController {
//			return self.autoGetTopController(of: presentedVC)
//		}
//		if let tabBarController = ViewController as? UITabBarController,
//			let selectVC = tabBarController.selectedViewController {
//			return self.autoGetTopController(of: selectVC)
//		}
//
//		if let navigationController = ViewController as? UINavigationController,
//			let visibleVC = navigationController.visibleViewController{
//			return self.autoGetTopController(of: visibleVC)
//		}
//		if let pageVC = ViewController as? UIPageViewController,
//			pageVC.viewControllers?.count == 1{
//			return self.autoGetTopController(of: pageVC.viewControllers?.first)
//		}
//
//		return ViewController
//	}
//
//
////	func openURLHost(host:String) -> UIViewController? {
////	}
////
//
//
//}
