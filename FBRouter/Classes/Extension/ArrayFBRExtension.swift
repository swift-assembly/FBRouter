//
//  ArrayFBRExtension.swift
//  FBExtension
//
//  Created by flywithbug on 2020/5/18.
//

import UIKit

public extension Array where Element:UIViewController {
    typealias FBRValidationBlock = (_ obj:UIViewController)->Bool
    
    func fb_match(validate:FBRValidationBlock) -> UIViewController?{
        for item in self{
            if validate(item)  {
                return item
            }
        }
        return nil
    }
    
    
}

