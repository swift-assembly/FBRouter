//
//  UIViewControllerFBRExtension.swift
//  Example
//
//  Created by Ori on 2020/5/17.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit

public extension UIViewController {
    func handleWithURLAction(_ urlAction:FBURLAction) ->Bool{
        
        return true
    }
	
    class func needsLogin(_ urlAction:FBURLAction) ->Bool{
        return false
    }
    
    class func isSingleton() -> Bool{
        return false
    }
	
	
}
