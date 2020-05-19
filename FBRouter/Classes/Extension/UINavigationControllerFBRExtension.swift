//
//  UINavigationControllerFBRExtension.swift
//  Example
//
//  Created by Ori on 2020/5/17.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit


public extension UINavigationController {
	func pushViewController(_ viewController:UIViewController, completion: (() -> Void)? = nil) {
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		pushViewController(viewController, animated: true)
		CATransaction.commit()
	}
    
    
	func popViewController(animated:Bool = true, _ completion: (() -> Void)? = nil){
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		popViewController(animated: animated)
		CATransaction.commit()
	}
	
	
	
	
	
}

