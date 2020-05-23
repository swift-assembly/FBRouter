//
//  ViewController03.swift
//  Example
//
//  Created by Ori on 2020/5/23.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter


class ViewController03: UIViewController {

    override func handleWithURLAction(_ urlAction: FBURLAction) -> Bool {
		let abc:Bool = urlAction.bool("abc") ?? false
		print("abc:",abc)
        return super.handleWithURLAction(urlAction)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "03"
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
		let button:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
		button.setTitle("test", for: UIControl.State.normal)
		button.setTitleColor(UIColor.black, for: UIControl.State.normal)
		button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 30)
		self.view.addSubview(button)
		button.addTarget(self, action: #selector(buttonAction(_:)), for: UIControl.Event.touchUpInside)
		
		let button1:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
		button1.setTitle("vc00", for: UIControl.State.normal)
		button1.setTitleColor(UIColor.black, for: UIControl.State.normal)
		button1.frame = CGRect.init(x: 100, y: 150, width: 100, height: 30)
		self.view.addSubview(button1)
		button1.tag = 100
		button1.addTarget(self, action: #selector(buttonAction(_:)), for: UIControl.Event.touchUpInside)
		
		let button2:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
		button2.setTitle("vc01", for: UIControl.State.normal)
		button2.setTitleColor(UIColor.black, for: UIControl.State.normal)
		button2.frame = CGRect.init(x: 100, y: 200, width: 100, height: 30)
		self.view.addSubview(button2)
		button2.tag = 101
		button2.addTarget(self, action: #selector(buttonAction(_:)), for: UIControl.Event.touchUpInside)
    }
        
    @objc func buttonAction(_ sender:UIButton) {
		if sender.tag == 100 {
			let urlAction = FBURLAction.init(host: "vc00?a=b")
			urlAction.completeBlock = {
				(succes) in
				print("succes:",urlAction.url!)
			}
			FBRouter.router().openURLAction(urlAction,from: self)
			return
		}
		
		if sender.tag == 101 {
			let urlAction = FBURLAction.init(host: "vc01?a=b")
			urlAction.completeBlock = {
				(succes) in
				print("succes:",urlAction.url!)
			}
			FBRouter.router().openURLAction(urlAction,from: self)
			return
		}
        let urlAction = FBURLAction.init(host: "vc04?a=b")
		urlAction.completeBlock = {
			(succes) in
			print("succes:",urlAction.url!)
		}
        FBRouter.router().openURLAction(urlAction,from: self)
    }

}
