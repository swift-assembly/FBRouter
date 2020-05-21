//
//  FBBaseRouter.swift
//  Example
//
//  Created by Ori on 2020/5/17.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit


public class FBBaseRouter:NSObject {
 
    //默认导航控制器类
    var BaseNavgClass:UINavigationController.Type =  UINavigationController.self
    var currentNavigationController:UINavigationController?
	var scheme:String
	var urlMappings:Dictionary<String,FBURLTarget>
    var urlActionWaitingList:Array<FBURLAction>
    var checkBlockTimer:Timer?
	var lock:NSLock
	var animating: Bool
    var openSuccess:Bool = false
    
    
	public override init() {
		self.animating = false
		self.scheme = "fb"
		self.urlMappings = Dictionary.init()
        self.urlActionWaitingList = Array.init()
		self.lock = NSLock.init()
	}
	
	func setScheme(scheme:String)  {
		self.scheme = scheme
	}
    
    func inBlockMode() -> Bool {
        return self.currentNavigationController?.inAnimating ?? false
    }
    
    /// 注册路由
    /// - Parameter urlmappings: urlmappings  <routerHost,className>
	public func registURLMapping(urlmappings:Dictionary<String,String>)  {
		lock.lock()
        defer {lock.unlock()}
		for item in urlmappings{
			self.urlMappings[item.key] = FBURLTarget.init(key: item.key, target: item.value)
		}
		
	}
	@discardableResult
    func matchTargetWithURLAction(urlAction:FBURLAction) -> FBURLTarget? {
        guard let host = urlAction.url?.host  else{
            return nil
        }
        return self.urlMappings[host]
    }
    
    
	@discardableResult
    func obtainTargetControllerCheckURLAction(_ urlAction:FBURLAction,
                                              navigationController:UINavigationController?) -> UIViewController? {
        guard let targetClass = urlAction.urlTarget?.targetClass as? UIViewController.Type else {
            return nil
        }
        var isSingleton = urlAction.isSingleton
        if targetClass.isSingleton(urlAction) {
            isSingleton = true
        }
        if isSingleton  {
            let viewController = navigationController?.viewControllers.fb_match(
            validate: { (item:UIViewController) -> Bool in
                return item.isKind(of: targetClass)
            })
            if viewController != nil {
                return viewController
            }
        }
        let viewController = targetClass.init()
        viewController.setURLAction(urlAction: urlAction)
        return viewController
	}
    @discardableResult
    public func openURLAction(_ urlAction:FBURLAction,from:UIViewController?) -> UIViewController? {
        openSuccess = false
        urlAction.from = from
        defer {
            callBack(urlAction: urlAction, success: openSuccess)
        }
        //校验参数
        
        guard shouldOpenURLAction(urlAction: urlAction) else{
            return nil
        }
        
        guard !urlAction.openExternal  else {
            guard !willOpenExternal(urlAction: urlAction) else {
                return nil
            }
            openExternal(urlAction: urlAction, completionHandler:{
                (success) in
                self.didOpenExternal(urlAction: urlAction,success:success )
                guard let complete = urlAction.completeBlock else{
                    return
                }
                complete(success)
            })
            return nil
        }

        urlAction.urlTarget = self.matchTargetWithURLAction(urlAction: urlAction)
        guard urlAction.urlTarget != nil else{
            onMatchUnhandledURLAction(urlAction: urlAction)
            openSuccess = false
            return nil
        }
        var viewController : UIViewController?
        if urlAction.options.count == 0 || urlAction.options.contains(FBRouterOptions.push)  {
            viewController = push(urlAction, from: from)
        }else if urlAction.options.contains(FBRouterOptions.present) {
            viewController = present(urlAction, from: from)
        }
        guard (viewController != nil) else{
            return nil
        }
        onMatchViewController(viewController!, urlAction: urlAction)
        openSuccess = true
        return viewController
    }
    //push页面
    func push(_ urlAction:FBURLAction,from:UIViewController?) -> UIViewController? {
        //获取顶层控制器的导航栏
        guard let navigationContrller = from?.navigationController ?? UIViewController.topController?.navigationController else {
            onMatchUnhandledURLAction(urlAction: urlAction)
            return nil
        }
    
        guard let viewController = obtainTargetControllerCheckURLAction(urlAction,navigationController: navigationContrller) else {
            onMatchUnhandledURLAction(urlAction: urlAction)
            return nil
        }
        
        guard let navigationController = from?.navigationController else {
            onMatchUnhandledURLAction(urlAction: urlAction)
            return nil
        }
        if navigationController.inBlockMode() {
            self.urlActionWaitingList.append(urlAction)
            self.startTimer()
            return viewController
        }
        navigationController.pushViewController(viewController)
        return viewController
    }
    
    //presentVC
    func present(_ urlAction:FBURLAction,from:UIViewController?) -> UIViewController? {
        //获取顶层控制器的导航栏
        guard let currentViewController = from ?? UIViewController.topController else {
          onMatchUnhandledURLAction(urlAction: urlAction)
          return nil
        }
        guard let viewController = obtainTargetControllerCheckURLAction(urlAction,navigationController: currentViewController.navigationController) else {
            onMatchUnhandledURLAction(urlAction: urlAction)
            return nil
        }
        if urlAction.options.contains(FBRouterOptions.wrap_nc) {
            currentViewController.present(UINavigationController.init(rootViewController: viewController), animated: urlAction.animation)
        }else{
            currentViewController.present(viewController, animated: urlAction.animation)
        }
        return viewController
    }
    
    
    @objc func checkTimerBlockModeDismiss() {
        
    }
    
    func flush()  {
        while urlActionWaitingList.count > 0 {
            if self.inBlockMode(){
                self.startTimer()
                return;
            }
            let urlAction = urlActionWaitingList.first!
            urlActionWaitingList.removeFirst()
            openURLAction(urlAction,from: urlAction.from ?? nil)
        }
       
    }
    
    func startTimer() {
        if(checkBlockTimer == nil){
            checkBlockTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(checkTimerBlockModeDismiss), userInfo: nil, repeats: true)
        }
    }
    
    
	@discardableResult
	func openURLAction(urlAction:FBURLAction) -> UIViewController? {
        
        return nil
	}
    
    
    
    func callBack(urlAction:FBURLAction,success:Bool) {
        guard let complete = urlAction.completeBlock else{
            return
        }
        complete(success)
    }
    

// MARK: -Methods
    /// 校验urlAction 是否合规
    /// - Parameter urlAction: urlAction description
    @objc open func shouldOpenURLAction(urlAction:FBURLAction) -> Bool {
        
        return true
    }
    
    
    /// 将要打开外链 可在此时校验是否让打开
    /// - Parameter urlAction: urlAction description
    @objc open func willOpenExternal(urlAction:FBURLAction)->Bool {
        return true
    }
    
    @objc open func didOpenExternal(urlAction:FBURLAction,success:Bool) {
        
    }
    
    /// 将要打开
    /// - Parameter urlAction: urlAction description
    @objc open func willOpenURLAction(urlAction:FBURLAction)  {
        
    }
    
    /// 匹配到不能打开的的URLAction,抛出
    /// - Parameter urlAction: urlAction description
    @objc open func onMatchUnhandledURLAction(urlAction:FBURLAction) {
        
    }
    
    
    /// 打开了对应页面
    /// - Parameters:
    ///   - controller: 目标控制器
    ///   - urlAction: urlAction
    @objc open func onMatchViewController(_ controller:UIViewController,urlAction:FBURLAction)  {
        
    }
    
    
    /// 打开了外部链接
    /// - Parameters:
    ///   - urlAction: 参数
    ///   - completion: 回调
    @objc open func openExternal(urlAction:FBURLAction, completionHandler completion: ((Bool) -> Void)? = nil) {
        UIApplication.shared.open(urlAction.url!, options: [:], completionHandler:{
            (success) in
            guard let complete = urlAction.completeBlock else{
                return
            }
            complete(success)
        })
    }
    
    
    
    /// Description 判断是否需要登录
    /// - Parameters:
    ///   - urlAction: urlAction description
    ///   - controller: controller description
    @objc open func handleLoginAction(urlAction:FBURLAction,controller:UIViewController) -> Bool {
       
        return false
    }
    
}


