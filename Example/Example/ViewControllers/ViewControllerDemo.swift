//
//  ViewControllerDemo.swift
//  Example
//
//  Created by Ori on 2020/5/24.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter

class ViewControllerDemo: UIViewController,UITableViewDelegate,UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "UITableViewCell")
		let item = self.items[indexPath.row];
		cell.detailTextLabel?.text = ""
		switch item {
		case "push": 
			self.openHostString(host: "vc01")
			cell.detailTextLabel?.text = "router:vc01"
			break
		case "push_singleton":
			cell.detailTextLabel?.text = "router:home"
			break
		case "push_singleton_exist":
			cell.detailTextLabel?.text = "router:demo"
			break
		case "push_params":
			cell.detailTextLabel?.text = "router:vc01?a=b"
			break
		case "present":
			cell.detailTextLabel?.text = "router:vc05?a=b"
			break
		case "present_nav":
			cell.detailTextLabel?.text = "router:vc05?c=d"
			break
		default: break
			
		}
		cell.textLabel?.text = item
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = self.items[indexPath.row]
		switch item {
		case "push": 
			self.openHostString(host: "vc01")
			break
		case "push_singleton":
			let urlAction = FBURLAction.init(host: "home")
			//			urlAction.isSingleton = true
			//override class func isSingleton(_ urlAction: FBURLAction) -> Bool
			FBRouter.openURLAction(urlAction)
			break
		case "push_singleton_exist":
			let urlAction = FBURLAction.init(host: "demo")
			urlAction.options = [FBRouterOptions.force_push]
			self.openURLAction(urlAction)
			break
		case "push_params":
			let urlAction = FBURLAction.init(host: "vc01?a=b")
			urlAction.setBool("Bool", value: true)
			urlAction.setString("String", value: "String")
			urlAction.setDouble("Double", value: 2.0202)
			urlAction.setInteger("Integer", value: 101)
			let person:Person = Person.init()
			person.age = 18
			person.name = "nini"
			urlAction.setAny("person", value: person)
			FBRouter.router().openURLAction(urlAction)
			break
		case "present":
			let urlAction = FBURLAction.init(host: "vc05?a=b")
			urlAction.options = [FBRouterOptions.present]
			urlAction.setBool("Bool", value: true)
			urlAction.setString("String", value: "String")
			urlAction.setDouble("Double", value: 2.0202)
			urlAction.setInteger("Integer", value: 101)
			let person:Person = Person.init()
			person.age = 18
			person.name = "nini"
			urlAction.setAny("person", value: person)
			self.openURLAction(urlAction)
			break
		case "present_nav":
			let urlAction = FBURLAction.init(host: "vc05?a=b")
			urlAction.options = [FBRouterOptions.present,FBRouterOptions.wrap_nc]
			urlAction.setBool("Bool", value: true)
			urlAction.setString("String", value: "String")
			urlAction.setDouble("Double", value: 2.0202)
			urlAction.setInteger("Integer", value: 101)
			let person:Person = Person.init()
			person.age = 18
			person.name = "nini"
			urlAction.setAny("person", value: person)
			openURLAction(urlAction)
			break
		default: break
			
		}

		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	lazy var tableView:UITableView = {
		() -> UITableView in
		let temp = UITableView()
		temp.delegate = self
		temp.dataSource = self
		return temp
	}()
	
	var items:Array<String>=["push","push_singleton",
							 "force_push_singleton_exist","push_params","present","present_nav"]
	var details:Array<String>=["普通导航",
							   "push到一个单例页面",
							   "push一个栈内单例页面，强制push该页面",
							   "push页面带参数",
							   "present一个页面",
							   "present一个页面，并给加上导航控制器"]

	override class func isSingleton(_ urlAction: FBURLAction) -> Bool {
		return true
	}
	override func handleWithURLAction(_ urlAction: FBURLAction) -> Bool {
		print(urlAction.from as Any)
		return super.handleWithURLAction(urlAction)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		self.navigationItem.title = "Demo"

		self.view.addSubview(self.tableView)
		self.tableView.frame = self.view.bounds
		self.tableView.reloadData()
		
    }
	
	

}
