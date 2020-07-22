//
//  ImageModel.swift
//  Linguado
//
//  Created by Priba on 2/26/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation

class ImageModel{
    
    var fullUrl = ""
    var filePath = ""
    var id: Int16 = 0
    var position: Int16 = 0
    
    init() {
    }
    
    init(dict: NSDictionary){
        
        if let temp = dict["fullUrl"] as? String {
            fullUrl = temp
        }
        
        if let temp = dict["filePath"] as? String {
            filePath = temp
        }
        
        if let temp = dict["id"] as? Int16 {
            id = temp
        }
        
        if let temp = dict["position"] as? Int16 {
            position = temp
        }
        
    }
    
    func toDictionary() -> Dictionary<String, Any>{
        var dict = Dictionary<String, Any>()
        dict["fullUrl"] = self.fullUrl
        dict["filePath"] = self.filePath
        dict["id"] = self.id
        dict["position"] = self.position
        return dict
    }
}
