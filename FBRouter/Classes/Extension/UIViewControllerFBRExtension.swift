//
//  UIViewControllerFBRExtension.swift
//  Example
//
//  Created by Ori on 2020/5/17.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit


extension UIViewController {
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
    
}



extension UIViewController {

    private class var sharedApplication: UIApplication? {
      let selector = NSSelectorFromString("sharedApplication")
      return UIApplication.perform(selector)?.takeUnretainedValue() as? UIApplication
    }

    open class var topController:UIViewController?{
        guard let currentWindows = self.sharedApplication?.windows else {
            return nil
        }
        var rootVC:UIViewController?
        for window in currentWindows {
            if let windowRootVC = window.rootViewController, window.isKeyWindow{
                rootVC = windowRootVC
                break
            }
        }
        return self.autoGetTopController(of: rootVC)
    }

    open class  func autoGetTopController(of ViewController:UIViewController?) -> UIViewController? {
        if let presentedVC = ViewController?.presentedViewController {
            return self.autoGetTopController(of: presentedVC)
        }
        if let tabBarController = ViewController as? UITabBarController,
            let selectVC = tabBarController.selectedViewController {
            return self.autoGetTopController(of: selectVC)
        }

        if let navigationController = ViewController as? UINavigationController,
            let visibleVC = navigationController.visibleViewController{
            return self.autoGetTopController(of: visibleVC)
        }
        if let pageVC = ViewController as? UIPageViewController,
            pageVC.viewControllers?.count == 1{
            return self.autoGetTopController(of: pageVC.viewControllers?.first)
        }

        return ViewController
    }


}

