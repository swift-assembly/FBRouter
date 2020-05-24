//
//  ViewController01.swift
//  Example
//
//  Created by flywithbug on 2020/5/22.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter

class ViewController01: UIViewController {
    override func handleWithURLAction(_ urlAction: FBURLAction) -> Bool {
		let abc:Bool = urlAction.bool("abc") ?? false
		print("abc:",abc)
		let person = urlAction.anyObject("person") as? Person
		print("person:",person as Any)
        return super.handleWithURLAction(urlAction)
    }
	override class func isSingleton(_ urlAction: FBURLAction) -> Bool {
		return true
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "01"
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
          let button:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
          button.setTitle("test", for: UIControl.State.normal)
          button.setTitleColor(UIColor.black, for: UIControl.State.normal)
          button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 30)
          self.view.addSubview(button)
          button.addTarget(self, action: #selector(buttonAction(_:)), for: UIControl.Event.touchUpInside)
    }
        
    @objc func buttonAction(_ sender:UIButton) {
		
		/// push 到一个新页面
        let urlAction = FBURLAction.init(host: "vc02?a=b")
		urlAction.completeBlock = {
			(succes) in
			print("succes:",urlAction.url!)
		}
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
