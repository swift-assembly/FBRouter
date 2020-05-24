//
//  ViewController05.swift
//  Example
//
//  Created by Ori on 2020/5/24.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter

class ViewController05: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
		if self.presentingViewController != nil {
			self.navigationItem.title = "presented"
		}else{
			self.navigationItem.title = "05"
		}
        // Do any additional setup after loading the view.
		self.view.backgroundColor = UIColor.white
		let button:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
		button.setTitle("push", for: UIControl.State.normal)
		button.setTitleColor(UIColor.black, for: UIControl.State.normal)
		button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 30)
		self.view.addSubview(button)
		button.addTarget(self, action: #selector(buttonAction(_:)), for: UIControl.Event.touchUpInside)
		// Do any additional setup after loading the view.
	}
    
	@objc func buttonAction(_ sender:UIButton) {
		let urlAction = FBURLAction.init(host: "vc03")
		openURLAction(urlAction)
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
