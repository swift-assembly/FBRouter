//
//  FBURLAction.swift
//  Example
//
//  Created by Ori on 2020/5/16.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit

public enum FBTargetType {
	case FBTargetTypeController
	case FBTargetTypeBridge
}

public enum FBAnimationOptions {
	case FBAnimationOptionsPush
	case FBAnimationOptionsPresented
}

public class FBURLTarget:NSObject{
	var	key:String?
	var	targetString:String?
	var	targetClass:AnyClass?
	var targetType:FBTargetType?
	var	isSingleton:Bool
	public override init() {
		self.isSingleton = false
	}
	
	init(key:String,target:String){
		self.isSingleton = false
		self.key = key
		self.targetString = target
		self.targetClass =  FBClassFromString(string: target)
		if self.targetClass is UIViewController.Type{
			self.targetType = FBTargetType.FBTargetTypeController
		}
	}
	
	
	
	
	
	
	
}

public class FBURLAction:NSObject {
	var animation:Bool = false
	
	var url:URL?
	var urlTarget:FBURLTarget?
	var openExternal:Bool?
	
	var isSingleton:Bool?

	func URLFromString(host:String) -> URL? {
		if host == ""{
			return nil
		} 
		return  URL.init(string: FBRouter.router().scheme + "://" + host)
	}
	
	
	
	public override init() {
		super.init()
		
	}
	

	public convenience init(host:String) {
		self.init()
		self.url = URLFromString(host: host)
	}
	
	public convenience init(url:String) {
		self.init()
		self.url =  URL.init(string: url)
	}
	
	public convenience init(httpUrl:String) {
		self.init()		
//		let urlString = URLFromString(host: "web") 
		
	}
	
	
	
	
}


let KUrlCodingReservedCharacters = "!*'();:|@&=+$,/?%#[]{}"

extension String {
	@discardableResult
	mutating func urlEncode() -> String {
		if let encoded = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
			self = encoded
		}
		return self
	}
	
    @discardableResult
    mutating func urlDecode() -> String {
        if let decoded = removingPercentEncoding {
            self = decoded
        }
        return self
    }
}
