//
//  FBRouterControllerProtocol.swift
//  FBExtension
//
//  Created by flywithbug on 2020/5/18.
//

import UIKit


public protocol FBRouterControllerProtocol:AnyObject {
    static func isSingleton() -> Bool
    static func needsLogin(urlAction:FBURLAction) -> Bool
    func handleWithURLAction(urlAction:FBURLAction) ->Bool
}

