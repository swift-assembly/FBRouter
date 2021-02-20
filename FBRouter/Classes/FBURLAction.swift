//
//  FBURLAction.swift
//  Example
//
//  Created by Ori on 2020/5/16.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit

public enum FBTargetType {
     case undefined
     case controller
     case bridge
}


/// 动效枚举
public struct FBRouterOptions:OptionSet {
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    public let rawValue: UInt
    public static let push 			= 	FBRouterOptions(rawValue: 1 << 0)  	//push
	public static let force_push 	= 	FBRouterOptions(rawValue: 1 << 1)  	//if isSingleton = true force push 
	
	
    public static let present 		= 	FBRouterOptions(rawValue: 1 << 5) 	//present
    public static let wrap_nc 		= 	FBRouterOptions(rawValue: 1 << 6)  //add UINavigationController when present
    public static let fullScreen    =   FBRouterOptions(rawValue: 1 << 7)     //全屏
	
}


/// format URLString withscheme
/// - Parameter host: 
func URLFromString(host:String) -> URL {
    return  URL.init(string: FBRouter.router().scheme + "://" + host)!
}

public class FBURLAction:NSObject {
    
    public var options:[FBRouterOptions] = [FBRouterOptions.push]
    public private(set) var params:Dictionary<String, Any> = [:]
	public var animation:Bool = true
	
	public var openExternal:Bool = false
	public var isSingleton:Bool = false
	
    public weak var from:UIViewController?
    public var completeBlock:((Bool)->Void)? = nil
    public var url:URL?
	public var urlTarget:FBURLTarget?
	public var openSuccess:Bool = false
    public var callBackBlock:((Any)->Void)? = nil
    
    
    
	override init() {
		super.init()
	}
    
    public convenience init(url:URL){
        self.init()
        self.url = url
        guard let para = url.queryParameters else {
            return
        }
        for item in para {
            params[item.key] = item.value
        }
    }
    
    public convenience init(urlString:String) {
        let url = URL.init(string: urlString) ?? URLFromString(host: "")
        self.init(url:url)
    }
    
	
	/// use scheme setting
	/// - Parameter host: 
	public convenience init(host:String) {
        self.init(url:URLFromString(host: host))
	}
    
	public convenience init(httpUrl:String?) {
		var url = URLFromString(host: "web")
		if httpUrl?.isBlank == false{
            url = url.appendingQueryParameters(["url" : httpUrl!])
		}
        self.init(url:url)
	}
    
    func setCompleteBlock(_ block: ((Bool) -> Void)? = nil) {
        self.completeBlock = block
    }
    
}


extension FBURLAction{
	
	/// 传递参数给下一个控制器
	/// - Parameters:
	///   - key: key String
	///   - value: value
    public func setInteger(_ key:String, value:NSInteger) {
        self.params[key] = value
    }
	
    public func setInt(_ key:String, value:Int) {
        self.params[key] = value
    }
    public func setDouble(_ key:String, value:Double) {
        self.params[key] = value
    }
    public func setString(_ key:String, value:String) {
        self.params[key] = value
    }
    public func setBool(_ key:String, value:Bool) {
        self.params[key] = value
    }
    public func setAny(_ key:String, value:Any) {
        self.params[key] = value
    }
    
    public func setInt(_ value:Int, key:String) {
        self.params[key] = value
    }
    public func setDouble(_ value:Double,key:String) {
        self.params[key] = value
    }
    public func setString(_ value:String, key:String) {
        self.params[key] = value
    }
    public func setBool(_ value:Bool, key:String) {
        self.params[key] = value
    }
    public func setAny(_ value:Any, key:String) {
        self.params[key] = value
    }
    
    public func integer(_ key:String) -> NSInteger? {
        return self.params[key] as? NSInteger
    }
	public func int(_ key:String) -> Int? {
		   return self.params[key] as? Int
	   }
    public func double(_ key:String) -> Double? {
        return self.params[key] as? Double
    }
    public func string(_ key:String) -> String? {
        return self.params[key] as? String
    }
    public func bool(_ key:String) -> Bool?{
        return self.params[key] as? Bool
    }
    public func setInteger(_ value:NSInteger, key:String) {
        self.params[key] = value
    }
    
    
    public func anyObject(_ key:String) -> Any?{
        return self.params[key]
    }
	
    public func addEntriesFromDictonary(entries:Dictionary<String, Any>){
        for item in entries{
//            if item.key == "url" {
//                continue
//            }
            self.params[item.key] = item.value
        }
    }
	
    public func addParamsFromURLAction(urlAction:FBURLAction) {
        self.addEntriesFromDictonary(entries: urlAction.params)
    }
}


extension String {
	var isBlank: Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
    
}


public class FBURLTarget:NSObject{
    public var    key:String?
    public var    targetString:String?
    public var    targetClass:AnyClass?
    public var    bundle:String?
    public var    targetType:FBTargetType = FBTargetType.undefined
    
    
    public override init() {
        self.targetType = FBTargetType.undefined
    }
    
    public convenience  init(key:String,target:String,bundle:String){
        self.init()
        self.key = key
        self.targetString = target
        self.targetClass =  FBClassFromString(string: target,bundle: bundle)
        if self.targetClass is UIViewController.Type{
            self.targetType = FBTargetType.controller
        }
    }
}


extension UIViewController {
    private struct AssociatedKey {
        static var urlActionIdentifier: String = "urlActionIdentifier"
    }
    public var urlAction:FBURLAction?{
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.urlActionIdentifier) as? FBURLAction
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.urlActionIdentifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setURLAction(urlAction:FBURLAction) {
        self.urlAction = urlAction
    }
    
    convenience init(urlAction:FBURLAction) {
        self.init()
        self.urlAction = urlAction
        
    }
    
}
