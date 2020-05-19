//
//  UIViewControllerFBRExtension.swift
//  Example
//
//  Created by Ori on 2020/5/17.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit


extension UIViewController {
    @objc open func handleWithURLAction(_ urlAction:FBURLAction) ->Bool{
        return true
    }
    
    @objc open class func needsLogin(_ urlAction:FBURLAction) ->Bool{
        return false
    }

    @objc open class func isSingleton(_ urlAction:FBURLAction) -> Bool{
        return false
    }
    
}
