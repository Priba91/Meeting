//
//  CountryModel.swift
//  Linguado
//
//  Created by Priba on 2/27/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation

class CountryModel: Copying{
    
    var code = ""
    var flag = ""
    var id:Int16 = 0
    var langId:Int16 = 0
    var level = 0
    var name = ""
    var nameTranslated = ""
    var nativeName = ""
    var nativeNameOfficial = ""
    var selected = false
    
    required init(original: CountryModel) {
        self.name = original.name
        self.nativeName = original.nativeName
        self.code = original.code
        self.flag = original.flag
        self.id = original.id
        self.langId = original.langId
        self.level = original.level
        self.selected = original.selected

    }
    
    func copy(with zone: NSZone? = nil) -> CountryModel {
        return CountryModel(original: self)
    }
    
    init (){}
    
    init (id: Int16, name: String, level: Int){
        self.id = id
        self.name = name
        self.level = level
    }
    
    func toDictionary() -> Dictionary<String, Any>{
        var dict = Dictionary<String, Any>()
        
        dict["code"] = code
        dict["flag"] = flag
        dict["id"] = id
        dict["langId"] = langId
        dict["level"] = level
        dict["name"] = name
        dict["nameTranslated"] = nameTranslated
        dict["nativeName"] = nativeName
        dict["nativeNameOfficial"] = nativeNameOfficial

        return dict
    }
    
    init (dict: NSDictionary){
        print(dict)
        if let temp = dict["code"] as? String {
            code = temp
        }
        
        if let temp = dict["flag"] as? String {
            flag = temp
        }
        
        if let temp = dict["id"] as? Int16 {
            id = temp
        }
        
        if let temp = dict["langId"] as? Int16 {
            langId = temp
        }
        
        if let temp = dict["level"] as? Int {
            level = temp
        }
        
        if let temp = dict["name"] as? String {
            name = temp
        }
        
        if let temp = dict["nameTranslated"] as? String {
            nameTranslated = temp
        }
        
        if let temp = dict["nativeName"] as? String {
            nativeName = temp
        }
        
        if let temp = dict["nativeNameOfficial"] as? String {
            nativeNameOfficial = temp
        }
    }
    
    func getName()-> String {
        if nameTranslated != "" {
            return nameTranslated
        }
        
        return name
    }
}


extension Array where Element: CountryModel {
    func resetSelected() {
        for element in self {
            element.selected = false
            element.level = 1
        }
    }
}
