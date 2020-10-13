//
//  FBBaseRouter.swift
//  Example
//
//  Created by Ori on 2020/5/17.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit


open class FBNavigator:NSObject {

	/// routerMappings
    public var urlMappings:Dictionary<String,String>
	public var urlTargetMappings:Dictionary<String,FBURLTarget>
	
	
    public var currentNavigationController:UINavigationController?
    open weak var deleage:FBRouterDelegate?
	
	public var wrapNavgClass:UINavigationController.Type =  UINavigationController.self
	
    var timerDuration:TimeInterval = 0.40
    
	var scheme:String
    var urlActionWaitingList:Array<FBURLAction>
    var checkBlockTimer:Timer?
	var lock:NSLock
	var animating: Bool
    var openSuccess:Bool = false
    
    
	public override init() {
		self.animating = false
		self.scheme = "fb"
		self.urlMappings = Dictionary.init()
		self.urlTargetMappings = Dictionary.init()
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
    /// - Parameter urlmappings: urlmappings  <routerHost,className>, 所处bundle名称
    public func registURLMapping(urlmappings:Dictionary<String,String>,bundle:String)  {
		lock.lock()
        defer {lock.unlock()}
		for item in urlmappings{
			self.urlTargetMappings[item.key] = FBURLTarget.init(key: item.key, target: item.value,bundle: bundle)
			self.urlMappings[item.key] = item.value
		}
	}
    //bundleClass 注册类所处bundle
    public func registURLMapping(urlmappings:Dictionary<String,String>,bundleClass:AnyClass)  {
        let bundleName = FBBundleNameFromClass(_class: bundleClass)
        registURLMapping(urlmappings: urlmappings, bundle: bundleName)
    }
    
	@discardableResult
    func matchTargetWithURLAction(urlAction:FBURLAction) -> FBURLTarget? {
        guard let host = urlAction.url?.host  else{
            return nil
        }
        return self.urlTargetMappings[host]
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
				if !viewController!.handleWithURLAction(urlAction) {return nil}
                return viewController
            }
        }
        let viewController = targetClass.init()
        viewController.setURLAction(urlAction: urlAction)
        if !viewController.handleWithURLAction(urlAction) {return nil}
        return viewController
	}
    @discardableResult
    public func openURLAction(_ urlAction:FBURLAction,from:UIViewController?) -> UIViewController? {
        urlAction.from = from
        defer {
			if !urlAction.openSuccess {
				 callBack(urlAction: urlAction, success: urlAction.openSuccess)
			}
        }
        //校验参数
        guard shouldOpenURLAction(urlAction: urlAction) else{
            return nil
        }
		
		//判断是否应用scheme
		if urlAction.url?.scheme != self.scheme {
			urlAction.openExternal = true
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
        guard urlAction.urlTarget?.targetType == FBTargetType.controller else{
            onMatchUnhandledURLAction(urlAction: urlAction)
            return nil
        }
        var viewController : UIViewController?
		
		
        if urlAction.options.count == 0 || urlAction.options.contains(FBRouterOptions.push)||urlAction.options.contains(FBRouterOptions.force_push)  {
            viewController = push(urlAction, from: from)
        }else if urlAction.options.contains(FBRouterOptions.present) {
            viewController = present(urlAction, from: from)
        }
        guard (viewController != nil) else{
            return nil
        }
        onMatchViewController(viewController!, urlAction: urlAction)
        return viewController
    }
    @discardableResult
    public func openURLAction(_ urlAction:FBURLAction) -> UIViewController? {
        guard let from = UIViewController.topMost else {
            return nil
        }
        return openURLAction(urlAction, from: from)
    }
    //push页面
    func push(_ urlAction:FBURLAction,from:UIViewController?) -> UIViewController? {
        //获取顶层控制器的导航栏
        guard let navigationContrller = from?.navigationController ?? UIViewController.topMost?.navigationController else {
            onMatchUnhandledURLAction(urlAction: urlAction)
            return nil
        }
		currentNavigationController = navigationContrller
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
        push(urlAction: urlAction, viewController: viewController, navigationController: navigationController)
        return viewController
    }
    
    func push(urlAction:FBURLAction,
              viewController:UIViewController,
              navigationController:UINavigationController) {
        var isSingleton = urlAction.isSingleton
        if !isSingleton {
            isSingleton = urlAction.urlTarget?.targetClass!.isSingleton(urlAction) ?? false
        }
		var pop:Bool = false
        if isSingleton && navigationController.viewControllers.contains(viewController){
			pop = true
			if urlAction.options.contains(FBRouterOptions.force_push) {
				pop = false
				if viewController == navigationController.viewControllers.last {
					self.callBack(urlAction: urlAction, success: true)
					return;
				}
				navigationController.viewControllers.removeAll { (vc) -> Bool in
					return vc == viewController
				}
			}
        }
		urlAction.openSuccess = true
		if pop {
			navigationController.popToViewController(viewController, animated: urlAction.animation) { (controllers) in
				self.callBack(urlAction: urlAction, success: true)
			}
			return
		}
		navigationController.pushViewController(viewController, animated: urlAction.animation) { 
			()in
			self.callBack(urlAction: urlAction, success: true)
		}
    }
    
    
    
    //presentVC
    func present(_ urlAction:FBURLAction,from:UIViewController?) -> UIViewController? {
        //获取顶层控制器的导航栏
        guard let currentViewController = from ?? UIViewController.topMost else {
            onMatchUnhandledURLAction(urlAction: urlAction)
            return nil
        }

        guard let viewController = obtainTargetControllerCheckURLAction(urlAction,navigationController: currentViewController.navigationController) else {
            onMatchUnhandledURLAction(urlAction: urlAction)
            return nil
        }
        if urlAction.options.contains(.fullScreen) {
            viewController.modalPresentationStyle = .fullScreen
        }
        if urlAction.options.contains(FBRouterOptions.wrap_nc) {
            let navc = wrapNavgClass.init(rootViewController: viewController)
			currentViewController.present(navc, animated: urlAction.animation)
        }else{
            
            currentViewController.present(viewController, animated: urlAction.animation)
        }
        return viewController
    }
    
    
    @objc func checkTimerBlockModeDismiss() {
        if urlActionWaitingList.count  == 0{
            self.stopTimer()
            return
        }
        if !self.inBlockMode() {
            self.stopTimer()
            self.flush()
        }
    }
    
    func flush()  {
        while urlActionWaitingList.count > 0 {
            if self.inBlockMode(){
                self.startTimer()
                return
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
    func stopTimer()  {
        if checkBlockTimer != nil{
            checkBlockTimer?.invalidate()
            checkBlockTimer = nil
        }
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
        guard self.deleage?.shouldOpenURLAction(urlAction) != false else {
            return false
        }
        return true
    }
    
    
    /// 将要打开外链 可在此时校验是否让打开
    /// - Parameter urlAction: urlAction description
    @objc open func willOpenExternal(urlAction:FBURLAction)->Bool {
        guard self.deleage?.willOpenExternal(urlAction) != false else {
            return false
        }
        return true
    }
    
    @objc open func didOpenExternal(urlAction:FBURLAction,success:Bool) {
        self.deleage?.didOpenExternal(urlAction, success:success)
    }
    
    /// 将要打开
    /// - Parameter urlAction: urlAction description
    @objc open func willOpenURLAction(urlAction:FBURLAction)  {
        self.deleage?.willOpenURLAction(urlAction)
    }
    
    /// 匹配到不能打开的的URLAction,抛出
    /// - Parameter urlAction: urlAction description
    @objc open func onMatchUnhandledURLAction(urlAction:FBURLAction) {
        self.deleage?.onMatchUnhandledURLAction(urlAction)
    }
    
    
    /// 打开了对应页面
    /// - Parameters:
    ///   - controller: 目标控制器
    ///   - urlAction: urlAction
    @objc open func onMatchViewController(_ controller:UIViewController,urlAction:FBURLAction)  {
        self.deleage?.onMatchViewController(controller, urlAction: urlAction)
    }
    
    
    /// 打开了外部链接
    /// - Parameters:
    ///   - urlAction: 参数
    ///   - completion: 回调
    @objc open func openExternal(urlAction:FBURLAction, completionHandler completion: ((Bool) -> Void)? = nil) {
        guard (self.deleage?.openExternal(urlAction, completionHandler: completion)) != nil else{
            return
        }
        
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
        guard self.deleage?.handleLoginAction(urlAction, controller: controller) == false else{
            return true
        }
        return false
    }
    
}


