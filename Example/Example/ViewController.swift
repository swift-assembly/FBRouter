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
        self.view.backgroundColor = UIColor.white
        let button:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("test", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 30)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func buttonAction(_ sender:UIButton) {
        self.navigationController?.pushViewController(ViewController.init(), animated: true)
//        self.navigationController?.pushViewController(ViewController(), completion: {
//            () in
//        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}



