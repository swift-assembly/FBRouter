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
        
        self.view.backgroundColor = UIColor.white
        let button:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("test", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 30)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func buttonAction(_ sender:UIButton) {
//        self.navigationController?.pushViewController(ViewController.init(), animated: true)
////        self.navigationController?.pushViewController(ViewController(), completion: {
////            () in
////        })
//        self.dismiss(animated: true) {
//            ()in
//
//        }
        self.pageType = Int(arc4random() % 8)
        let vc = ViewController()
//        vc.modalPresentationStyle = UIModalPresentationStyle.init(rawValue: self.pageType) ?? UIModalPresentationStyle.fullScreen;
       
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func test()  {
//        FBURLAction.init(url: "a").options = FBRouterOptions.present
    }

}



