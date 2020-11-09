//
//  UINavigationControllerFBRExtension.swift
//  Example
//
//  Created by Ori on 2020/5/17.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit

// MARK - Extension
extension UINavigationController :UIGestureRecognizerDelegate{
    
    func inBlockMode() -> Bool {
        return self.inAnimating;
    }
    
    private struct AssociatedKey {
        static var inAnimatingIdentifier: String = "inAnimatingIdentifier"
    }
    
    
    
    public var inAnimating:Bool{
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.inAnimatingIdentifier) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.inAnimatingIdentifier, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    
    
    public func pushViewController(_ viewController:UIViewController, completion: (() -> Void)? = nil) {
        inAnimating = true
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            ()in
            self.inAnimating = false
            guard completion != nil else{
                return;
            }
            completion!()
        }
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
    
    public func pushViewController(_ viewController:UIViewController, animated:Bool, completion: (() -> Void)? = nil) {
        inAnimating = true
        if !animated {
            pushViewController(viewController, animated: animated)
            inAnimating = false
            guard completion != nil else{
                return;
            }
            completion!()
            return
        }
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            ()in
            self.inAnimating = false
            guard completion != nil else{
                return;
            }
            completion!()
        }
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
    public func popViewController(animated:Bool = true, _ completion: (() -> Void)? = nil){
        CATransaction.begin()
        CATransaction.setCompletionBlock{
            ()in
            guard completion != nil else{
                return;
            }
            completion!()
        }
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    public func popToViewController(_ viewController:UIViewController,animated:Bool = true, _ completion: (([UIViewController]?) -> Void)? = nil){
        var controllers:[UIViewController]?
        CATransaction.begin()
        controllers = popToViewController(viewController, animated: animated)
        CATransaction.setCompletionBlock{
            ()in
            guard completion != nil else{
                return;
            }
            completion!(controllers)
        }
        CATransaction.commit()
    }
    
    
    
    @objc func fbr_pushViewController(_ viewController:UIViewController,
                                      animated:Bool = true){
        if !animated && !(viewController.urlAction?.animation ?? false){
            fbr_pushViewController(viewController, animated: animated)
            self.inAnimating = false
            return
        }
        self.inAnimating = true
        CATransaction.begin()
        fbr_pushViewController(viewController, animated: animated)
        CATransaction.setCompletionBlock{
            ()in
            self.inAnimating = false
        }
        CATransaction.commit()
    }
    
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer == interactivePopGestureRecognizer) {
            return viewControllers.last?.canSlideBack() ?? false
        }
        return false
    }
    
    
    class func initializeMethod() {
        self.swizzleMethod(for: self, originalSelector: #selector(pushViewController(_:animated:)), swizzledSelector: #selector(fbr_pushViewController(_:animated:)))
    }
    
}

