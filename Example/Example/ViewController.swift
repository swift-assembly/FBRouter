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
        
        return super.handleWithURLAction(urlAction)
    }
    
    override class func needsLogin(_ urlAction: FBURLAction) -> Bool {
        return super.needsLogin(urlAction)
    }
    
    override class func isSingleton(_ urlAction: FBURLAction) -> Bool {
        return super.isSingleton(urlAction)
    }
    var pageType:Int = 0
    
	override func viewDidLoad() {
		super.viewDidLoad()
        self.navigationItem.title = "00"
        self.view.backgroundColor = UIColor.white
        let button:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("test", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 30)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: UIControl.Event.touchUpInside)

    }
    
    @objc func buttonAction(_ sender:UIButton) {
        let urlAction = FBURLAction.init(host: "vc01?a=b")
        urlAction.isSingleton = true
        print(urlAction.params)
        FBRouter.router().openURLAction(urlAction,from: self)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func test()  {
//        FBURLAction.init(url: "a").options = FBRouterOptions.present
    }

}



