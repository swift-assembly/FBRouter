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

        //        FBURLAction.ini
//        FBURLTarget.init(key: T##String, target: T##String)
        print(object_getClass(self)!)
        print(ViewController.isSingleton())
//        FBURLAction.init(url: "a")
		// Do any additional setup after loading the view.
        print("aalall".base64Encoded!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.navigationController?.pushViewController(ViewController())
    }
    

}



