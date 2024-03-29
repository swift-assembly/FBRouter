//
//  UIViewControllerFBRExtension.swift
//  Example
//
//  Created by Ori on 2020/5/17.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit


extension UIViewController:UIGestureRecognizerDelegate {
    
    @discardableResult
    @objc open func handleWithURLAction(_ urlAction:FBURLAction) ->Bool{
        return true
    }
    
    @objc open class func needsLogin(_ urlAction:FBURLAction) ->Bool{
        return false
    }
    
    /// 栈内单例唯一：只在当前所处导航控制器的栈内单例
    /// - Parameter urlAction:
    @objc open class func isSingleton(_ urlAction:FBURLAction) -> Bool{
        return false
    }
    
    //是否允许侧滑返回- 默认允许
    @objc open func canSlideBack() -> Bool{
        return true
    }
    
    
//    @objc open func fbr_viewDidLoad() {
//        fbr_viewDidLoad()
//    }
    
    
    
    class func initializeVCMethod() {
//        self.swizzleMethod(for: self, originalSelector: #selector(viewDidLoad), swizzledSelector: #selector(fbr_viewDidLoad))
    }

}





extension UIViewController {
    
    private class var sharedApplication: UIApplication? {
      let selector = NSSelectorFromString("sharedApplication")
      return UIApplication.perform(selector)?.takeUnretainedValue() as? UIApplication
    }

    /// Returns the current application's top most view controller.
    public class var topMost: UIViewController? {
      guard let currentWindows = self.sharedApplication?.windows else { return nil }
      var rootViewController: UIViewController?
      for window in currentWindows {
        if let windowRootViewController = window.rootViewController, window.isKeyWindow {
          rootViewController = windowRootViewController
          break
        }
      }

      return self.topMost(of: rootViewController)
    }
    

    /// Returns the top most view controller from given view controller's stack.
    public class func topMost(of viewController: UIViewController?) -> UIViewController? {
      // presented view controller
      if let presentedViewController = viewController?.presentedViewController {
        return self.topMost(of: presentedViewController)
      }

      // UITabBarController
      if let tabBarController = viewController as? UITabBarController,
        let selectedViewController = tabBarController.selectedViewController {
        return self.topMost(of: selectedViewController)
      }

      // UINavigationController
      if let navigationController = viewController as? UINavigationController,
        let visibleViewController = navigationController.visibleViewController {
        return self.topMost(of: visibleViewController)
      }

      // UIPageController
      if let pageViewController = viewController as? UIPageViewController,
        pageViewController.viewControllers?.count == 1 {
        return self.topMost(of: pageViewController.viewControllers?.first)
      }

      // child view controller
      for subview in viewController?.view?.subviews ?? [] {
        if let childViewController = subview.next as? UIViewController {
          return self.topMost(of: childViewController)
        }
      }

      return viewController
    }
}

