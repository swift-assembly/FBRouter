//
//  NavigatorProtocol.swift
//  Example
//
//  Created by Ori on 2020/5/17.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit

public protocol FBRouterDelegate:AnyObject {
    /// 能否打开urlAction
    /// - Parameter urlAction: urlAction description
    func shouldOpenURLAction(_ urlAction:FBURLAction) -> Bool
    func willOpenExternal(_ urlAction:FBURLAction) -> Bool
    func didOpenExternal(_ urlAction:FBURLAction,success:Bool)
    func willOpenURLAction(_ urlAction:FBURLAction)
    func onMatchUnhandledURLAction(_ urlAction:FBURLAction)
    func onMatchViewController(_ controller:UIViewController,urlAction:FBURLAction)
	func openExternal(_ urlAction:FBURLAction, completionHandler completion: ((Bool) -> Void)?)
    func handleLoginAction(_ urlAction:FBURLAction,controller:UIViewController) -> Bool

}

