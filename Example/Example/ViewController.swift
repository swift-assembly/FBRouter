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

	override func viewDidLoad() {
		super.viewDidLoad()
//        FBBaseRouter.init().openURLAction(urlAction: <#T##FBURLAction#>)
//        FBURLAction.ini
//        FBURLTarget.init(key: T##String, target: T##String)
        print(object_getClass(self)!)
        print(self.classForCoder)
//        FBURLAction.init(url: "a")
		// Do any additional setup after loading the view.
	}


}

