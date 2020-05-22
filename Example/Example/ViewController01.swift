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
        
        return super.handleWithURLAction(urlAction)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "01"
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
