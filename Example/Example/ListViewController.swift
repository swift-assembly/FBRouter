//
//  ListViewController.swift
//  Example
//
//  Created by Ori on 2020/5/23.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter


class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "UITableViewCell")
		let item = self.items[indexPath.row];
		cell.textLabel?.text = item
		cell.detailTextLabel?.text = FBRouter.urlMappings()[item]
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
	
	

	lazy var tableView:UITableView = {
		() -> UITableView in
		let temp = UITableView()
		temp.delegate = self
		temp.dataSource = self
		return temp
	}()
	
	var items:Array<String>=[]
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		print(FBRouter.urlMappings())
		self.items  = FBRouter.urlMappings().keys.sorted { (value1, value2) -> Bool in
			return value1 < value2
		}
//		print(self.items[0])
		self.view.addSubview(self.tableView)
		self.tableView.frame = self.view.bounds
		self.tableView.reloadData()
		
    }
	
	
	
	
	

}
