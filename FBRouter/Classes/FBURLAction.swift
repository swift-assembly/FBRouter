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

public typealias FBRCompleteBlock = (Bool)->Void

public class FBURLAction:NSObject {
	public var animation:Bool = false
	public var openExternal:Bool = false
	public var isSingleton:Bool = false
	
    public var completeBlock:FBRCompleteBlock?
	public var url:URL?
	public var urlTarget:FBURLTarget?
	func URLFromString(host:String) -> URL? {
		return  URL.init(string: FBRouter.router().scheme + "://" + host)
	}
	
	override init() {
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
	
	public convenience init(httpUrl:String?) {
		self.init()
		self.url = URLFromString(host: "web")
		if httpUrl?.isBlank == false{
			self.url = self.url?.appendingQueryParameters(["url" : httpUrl!])
		}
	}
    
    func setCompleteBlock(block:@escaping FBRCompleteBlock) {
        self.completeBlock = block
    }
}



extension String {
	var isBlank: Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
}




public class FBURLTarget:NSObject{
    var    key:String?
    var    targetString:String?
    var    targetClass:AnyClass?
    var    targetType:FBTargetType?
    
    
    public override init() {
    }
    
    public convenience  init(key:String,target:String){
        self.init()
        self.key = key
        self.targetString = target
        self.targetClass =  FBClassFromString(string: target)
        if self.targetClass is UIViewController.Type{
            self.targetType = FBTargetType.FBTargetTypeController
        }
    }
}
