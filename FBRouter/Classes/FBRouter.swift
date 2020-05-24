//
//  FBRouter.swift
//  Example
//
//  Created by Ori on 2020/5/16.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit

public class FBRouter:FBBaseRouter{
	private static let shareInstance = FBRouter()
	private override init() {
		super.init()
        FBRSwizzleManager.shared()
		scheme = "fb"
	}
	public static func urlMappings () -> Dictionary<String,String>{
		return FBRouter.router().urlMappings
	}
	public static func hostTargetMappings() -> Dictionary<String,FBURLTarget> {
		return FBRouter.router().urlTargetMappings
	}
	public static func setScheme(scheme: String) {
        FBRouter.router().scheme = scheme
    }
	
    override func setScheme(scheme: String) {
        self.scheme = scheme
    }
    
	public class func router() -> FBRouter {
		return shareInstance
	}
	
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
    
   
}

public extension UIViewController{
    
	@discardableResult
	func openURLAction(_ urlAction:FBURLAction) -> UIViewController? {
        return FBRouter.router().openURLAction(urlAction,from: self)
    }
	@discardableResult
    func openURL(url:URL) -> UIViewController? {
        return openURLAction(FBURLAction.init(url: url))
    }
	@discardableResult
    func openURLString(urlString:String) -> UIViewController? {
        return openURLAction(FBURLAction.init(urlString: urlString))
    }
	@discardableResult
    func openHttpURLString(httpUrl:String) -> UIViewController? {
        return openURLAction(FBURLAction.init(httpUrl: httpUrl))
    }
}
