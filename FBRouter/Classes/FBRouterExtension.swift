//
//  FBRouterExtension.swift
//  Example
//
//  Created by Ori on 2020/5/16.
//  Copyright © 2020 Ori. All rights reserved.
//

import Foundation

let FBRouterAppName =  Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String?

public func  FBClassFromString(string: String)-> AnyClass?{
	let stringName = FBRouterAppName! + "." + string
	return NSClassFromString(stringName)
}

