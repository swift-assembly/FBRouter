//
//  RouterRegister.swift
//  Example
//
//  Created by Ori on 2020/5/23.
//  Copyright © 2020 Ori. All rights reserved.
//

import UIKit
import FBRouter

class RouterRegister: NSObject {
	public static func registerURLMappings() {
        let urlMappings = ["vc00":"ViewController",
						   "vc01":"ViewController01",
						   "vc02":"ViewController02",
						   "vc03":"ViewController03",
						   "vc04":"ViewController04"]
        FBRouter.router().registURLMapping(urlmappings: urlMappings)

	}
}
