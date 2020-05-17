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
	var lock:NSLock
	var animating: Bool
	public override init() {
		self.animating = false
		self.scheme = "fb"
		self.urlMappings = Dictionary.init()
		self.lock = NSLock.init()
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
	
	
	
	
	


}
