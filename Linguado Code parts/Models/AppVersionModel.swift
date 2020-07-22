//
//  AppVersionModel.swift
//  Linguado
//
//  Created by Milos Grujic on 7/29/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation

class AppVersionModel {
    
    var iosOptional = 0
    var iosMandatory = 0
    
    init(dict: NSDictionary) {
        
        if let temp = dict["iosOptional"] as? Int {
            iosOptional = temp
        }
        
        if let temp = dict["iosMandatory"] as? Int {
            iosMandatory = temp
        }
    
    }
    
    init() {}
    
}
