//
//  ViewController02.swift
//  Example
//
//  Created by Ori on 2020/5/23.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter

class ViewController02: UIViewController {

   override func handleWithURLAction(_ urlAction: FBURLAction) -> Bool {
		let abc:Bool = urlAction.bool("abc") ?? false
		print("abc:",abc)
        return super.handleWithURLAction(urlAction)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "02"
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
		let button:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
		button.setTitle("test", for: UIControl.State.normal)
		button.setTitleColor(UIColor.black, for: UIControl.State.normal)
		button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 30)
		self.view.addSubview(button)
		button.addTarget(self, action: #selector(buttonAction(_:)), for: UIControl.Event.touchUpInside)
		
		let button1:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
		button1.setTitle("force_push", for: UIControl.State.normal)
		button1.setTitleColor(UIColor.black, for: UIControl.State.normal)
		button1.frame = CGRect.init(x: 100, y: 150, width: 100, height: 30)
		self.view.addSubview(button1)
		button1.tag = 100
		button1.addTarget(self, action: #selector(buttonAction(_:)), for: UIControl.Event.touchUpInside)
    }
        
    @objc func buttonAction(_ sender:UIButton) {
		if sender.tag == 100 {
			let urlAction = FBURLAction.init(host: "vc01?a=b")
			urlAction.options =  [FBRouterOptions.force_push,FBRouterOptions.push]
			urlAction.isSingleton = true
			urlAction.completeBlock = {
				(succes) in
				print("succes:",urlAction.url!)
			}
			FBRouter.router().openURLAction(urlAction,from: self)
			return
		}
        let urlAction = FBURLAction.init(host: "vc03?a=b")
		urlAction.completeBlock = {
			(succes) in
			print("succes:",urlAction.url!)
		}
        FBRouter.router().openURLAction(urlAction,from: self)
    }

}
