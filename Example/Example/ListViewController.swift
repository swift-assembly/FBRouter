//
//  ListViewController.swift
//  Example
//
//  Created by Ori on 2020/5/23.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter


class ListViewController: UIViewController {

	lazy var tableView:UITableView = {
		() -> UITableView in
		let temp = UITableView()
		return temp
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		self.view.addSubview(self.tableView)
		self.tableView.frame = self.view.bounds
		print(FBRouter.urlMappings())
		
		
		
    }
	
	
	
	
	

}
