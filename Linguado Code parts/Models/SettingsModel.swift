//
//  SettingsModel.swift
//  Linguado
//
//  Created by Priba on 2/27/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation

class SettingsModel {
    
    var showAge = false
    var id:Int16 = 0
    var showLocation = false
    var isPushOn = false
    var visibility = false
    
    init() { }
    
    init(dict:NSDictionary){
        
        if let temp = dict["id"] as? Int16 {
            id = temp
        }
        
        if let temp = dict["age"] as? Bool {
            showAge = temp
        }
        
        if let temp = dict["location"] as? Bool {
            showLocation = temp
        }
        
        if let temp = dict["push"] as? Bool {
            isPushOn = temp
        }
        
        if let temp = dict["visibility"] as? Bool {
            visibility = temp
        }
        
    }
    
}
