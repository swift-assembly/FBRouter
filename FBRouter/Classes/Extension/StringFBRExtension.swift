//
//  StringFBRExtension.swift
//  FBExtension
//
//  Created by Ori on 2020/5/17.
//

import Foundation

let FBRouterAppName =  Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String?

public func  FBClassFromString(string: String)-> AnyClass?{
    let stringName = FBRouterAppName! + "." + string
    return NSClassFromString(stringName)
}

public func  FBClassFromString(string: String,_bundleClass:AnyClass)-> AnyClass?{
    let stringName = FBBundleNameFromClass(_class: _bundleClass) + "." + string
    return NSClassFromString(stringName)
}


public func  FBClassFromString(string: String,bundle:String)-> AnyClass?{
    let stringName = bundle + "." + string
    return NSClassFromString(stringName)
}

public func FBBundleNameFromClass(_class: AnyClass) -> String {
    let bundleName = String(NSStringFromClass(_class).split(separator: ".")[0])
    return bundleName
}
