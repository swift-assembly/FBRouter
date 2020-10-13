//
//  FBRouterExtension.swift
//  Example
//
//  Created by Ori on 2020/5/16.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit

extension  NSObject {
    public class func swizzleMethod(for aClass:AnyClass, originalSelector:Selector,swizzledSelector:Selector){
        let originalMethod = class_getInstanceMethod(aClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector)

        let didAddMethod = class_addMethod(aClass, originalSelector,
                                           method_getImplementation(swizzledMethod!),
                                           method_getTypeEncoding(swizzledMethod!))
        if didAddMethod {
           class_replaceMethod(aClass, swizzledSelector,
                               method_getImplementation(originalMethod!),
                               method_getTypeEncoding(originalMethod!))
        } else {
           method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}






class FBRSwizzleManager:NSObject {
    private static let shareManager:FBRSwizzleManager = {
        let shared = FBRSwizzleManager.init()
        return shared
    }()
    
    private override init(){
        UINavigationController.initializeMethod()
        UIViewController.initializeVCMethod()
    }
    
    @discardableResult
    public class func shared() -> FBRSwizzleManager{
        return shareManager
    }
}





