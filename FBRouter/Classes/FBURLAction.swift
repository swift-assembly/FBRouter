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
	var url:URL?
	
	
}
