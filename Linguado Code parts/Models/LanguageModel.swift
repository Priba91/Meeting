//
//  LanguageModel.swift
//  Linguado
//
//  Created by Priba on 2/27/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation

protocol Copying {
    init(original: Self)
}

class LanguageModel: Copying, Equatable, Hashable {
    
    var countryId = 0
    var countryName = ""
    var countryNameTranslated = ""
    var langId = 0
    var langName = ""
    var langNameTranslated = ""
    var flag = ""
    var expanded = false
    var showCountry = false
    var level = 1
    var showSpecifics = false
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self).hashValue)
    }
    
    required init(original: LanguageModel) {
        self.countryId = original.countryId
        self.countryName = original.countryName
        self.countryNameTranslated = original.countryNameTranslated
        self.langId = original.langId
        self.level = original.level
        self.langName = original.langName
        self.langNameTranslated = original.langNameTranslated
        self.showCountry = original.showCountry
        self.flag = original.flag
        self.expanded = original.expanded
        self.showSpecifics = original.showSpecifics
        
    }
    
    func copy(with zone: NSZone? = nil) -> LanguageModel {
        return LanguageModel(original: self)
    }
    
    static func ==(lhs: LanguageModel, rhs: LanguageModel) -> Bool {
        return lhs.langId == rhs.langId
    }
    
    init() {}
    
    init (dict: NSDictionary){
        
        if let temp = dict["countryId"] as? Int {
            countryId = temp
        }
        
        if let temp = dict["countryNameTranslated"] as? String {
            countryNameTranslated = temp
        }
        
        if let temp = dict["countryName"] as? String {
            countryName = temp
        }
        
        if let temp = dict["langId"] as? Int {
            langId = temp
        }
        
        if let temp = dict["level"] as? Int {
            level = temp
        }
        
        if let temp = dict["langName"] as? String {
            langName = temp
        }
        
        if let temp = dict["langNameTranslated"] as? String {
            langNameTranslated = temp
        }
        
        if let temp = dict["flag"] as? String {
            flag = temp
        }
        
        if let temp = dict["showCountry"] as? Bool {
            showCountry = temp
        }
        
        if let temp = dict["showSpecifics"] as? Bool {
            showSpecifics = temp
        }
    }
    
    func toDictionary() -> Dictionary<String, Any>{
        var dict = Dictionary<String, Any>()
        
        dict["countryId"] = countryId
        dict["countryName"] = self.countryName
        dict["countryNameTranslated"] = self.countryNameTranslated
        dict["langId"] = self.langId
        dict["langNameTranslated"] = self.langNameTranslated
        dict["langName"] = self.langName
        dict["flag"] = self.flag
        dict["showSpecifics"] = self.showSpecifics
   
        return dict
    }
    
    func toLevelDictionary() -> Dictionary<String, Any>{
        var dict = Dictionary<String, Any>()
        
        dict["langId"] = self.langId
        dict["level"] = self.level
        
        return dict
    }
    
    func getLanguageName()-> String{
        if langNameTranslated != ""{
            return langNameTranslated
        }
        return langName
    }
    
    func getCountryName()-> String{
        if countryNameTranslated != ""{
            return countryNameTranslated
        }
        return countryName
    }
}

extension Array where Element: Copying {
    func clone() -> Array {
        var copiedArray = Array<Element>()
        for element in self {
            copiedArray.append(element.copy())
        }
        return copiedArray
    }
}

extension Array where Element: LanguageModel {
    func resetSelected() {
        for element in self {
            element.expanded = false
        }
    }
}

extension Copying {
    func copy() -> Self {
        return Self.init(original: self)
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
