//
//  ViewController05.swift
//  Example
//
//  Created by Ori on 2020/5/24.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit

class ViewController05: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
		if (self.presentingViewController != nil) {
			self.navigationItem.title = "presented"
		}else{
			self.navigationItem.title = "05"
		}
		
        // Do any additional setup after loading the view.
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
