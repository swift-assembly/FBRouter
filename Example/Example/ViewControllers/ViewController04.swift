//
//  ViewController04.swift
//  Example
//
//  Created by Ori on 2020/5/23.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter

class ViewController04: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "04"
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
          let button:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
          button.setTitle("present", for: UIControl.State.normal)
          button.setTitleColor(UIColor.black, for: UIControl.State.normal)
          button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 30)
          self.view.addSubview(button)
          button.addTarget(self, action: #selector(buttonAction(_:)), for: UIControl.Event.touchUpInside)
    }
        
    @objc func buttonAction(_ sender:UIButton) {
//		self.openh
		//present Controller
		let urlAction = FBURLAction.init(host: "vc05")
		urlAction.options = [FBRouterOptions.present,FBRouterOptions.wrap_nc]
		openURLAction(urlAction)
    }

}
