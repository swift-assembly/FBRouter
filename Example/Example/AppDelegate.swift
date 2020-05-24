//
//  AppDelegate.swift
//  Example
//
//  Created by Ori on 2020/5/13.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,FBRouterDelegate{

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window!.backgroundColor = UIColor.white
        self.window!.rootViewController = UINavigationController.init(rootViewController: ListViewController.init())
		self.window!.makeKeyAndVisible()
		
		//注册路由
		RouterRegister.registerURLMappings()
		FBRouter.router().deleage = self
        
		return true
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		
	}
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
		
	}
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		
	}
	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
		return true
	}
	func applicationDidBecomeActive(_ application: UIApplication) {
		
	}
	func applicationWillResignActive(_ application: UIApplication) {
		
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		
	}

	

//FBRouterDelegate
	func shouldOpenURLAction(_ urlAction: FBURLAction) -> Bool {
		return true
	}
	
	func willOpenExternal(_ urlAction: FBURLAction) -> Bool {
		return true
	}
	
	func didOpenExternal(_ urlAction: FBURLAction, success: Bool) {
		
	}
	
	func willOpenURLAction(_ urlAction: FBURLAction) {
		
	}
	
	func onMatchUnhandledURLAction(_ urlAction: FBURLAction) {
		
	}
	
	func onMatchViewController(_ controller: UIViewController, urlAction: FBURLAction) {
		
	}
	
	func openExternal(_ urlAction: FBURLAction, completionHandler completion: ((Bool) -> Void)?) {
		UIApplication.shared.open(urlAction.url!, options: [:], completionHandler:{
            (success) in
            guard let complete = urlAction.completeBlock else{
                return
            }
            complete(success)
        })
	}
	
	func handleLoginAction(_ urlAction: FBURLAction, controller: UIViewController) -> Bool {
		return true
	}
	

}

