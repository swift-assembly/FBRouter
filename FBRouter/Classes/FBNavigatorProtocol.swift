//
//  NavigatorProtocol.swift
//  Example
//
//  Created by Ori on 2020/5/17.
//  Copyright © 2020 Ori. All rights reserved.
//

import Foundation

public protocol FBRouterControllerProtocol:AnyObject {
    static func isSingleton() -> Bool
    static func needsLogin(urlAction:FBURLAction) -> Bool
    func handleWithURLAction(urlAction:FBURLAction) ->Bool
    
}

