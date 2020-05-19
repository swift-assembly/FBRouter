//
//  ViewController.swift
//  Example
//
//  Created by Ori on 2020/5/13.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter
import FBExtension

class ViewController: UIViewController {

    override func handleWithURLAction(_ urlAction: FBURLAction) -> Bool {
        return true
    }
    
    override class func needsLogin(_ urlAction: FBURLAction) -> Bool {
        return false
    }
    
    override class func isSingleton(_ urlAction: FBURLAction) -> Bool {
        return false
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}



