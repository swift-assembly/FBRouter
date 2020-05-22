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

    
	public class func router() -> FBRouter {
		return shareInstance
	}
	
    
	
}
