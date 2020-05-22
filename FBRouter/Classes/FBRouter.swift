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
		scheme = "fb"
	}
    
    override func setScheme(scheme: String) {
        self.scheme = scheme
    }
    
    
	public class func router() -> FBRouter {
		return shareInstance
	}
	
    public func openURL(url:URL,from:UIViewController) -> UIViewController? {
        return openURLAction(FBURLAction.init(url: url), from: from)
    }
    public func openURLString(urlString:String,from:UIViewController) -> UIViewController? {
        return openURLAction(FBURLAction.init(urlString: urlString), from: from)
    }
    public func openHttpURLString(httpUrl:String,from:UIViewController) -> UIViewController? {
        return openURLAction(FBURLAction.init(httpUrl: httpUrl), from: from)
    }
    
    public func openURL(url:URL) -> UIViewController? {
        return openURLAction(FBURLAction.init(url: url))
    }
    public func openURLString(urlString:String) -> UIViewController? {
        return openURLAction(FBURLAction.init(urlString: urlString))
    }
    public func openHttpURLString(httpUrl:String) -> UIViewController? {
        return openURLAction(FBURLAction.init(httpUrl: httpUrl))
    }
   
}

public extension UIViewController{
    
    func openURL(url:URL,from:UIViewController) -> UIViewController? {
        return FBRouter.router().openURLAction(FBURLAction.init(url: url), from: from)
    }
    func openURLString(urlString:String,from:UIViewController) -> UIViewController? {
        return FBRouter.router().openURLAction(FBURLAction.init(urlString: urlString), from: from)
    }
    func openHttpURLString(httpUrl:String,from:UIViewController) -> UIViewController? {
        return FBRouter.router().openURLAction(FBURLAction.init(httpUrl: httpUrl), from: from)
    }
    
    func openURL(url:URL) -> UIViewController? {
        return FBRouter.router().openURLAction(FBURLAction.init(url: url))
    }
    func openURLString(urlString:String) -> UIViewController? {
        return FBRouter.router().openURLAction(FBURLAction.init(urlString: urlString))
    }
    func openHttpURLString(httpUrl:String) -> UIViewController? {
        return FBRouter.router().openURLAction(FBURLAction.init(httpUrl: httpUrl))
    }
    
    
}
