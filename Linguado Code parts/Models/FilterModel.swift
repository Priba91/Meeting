//
//  FilterModel.swift
//  JobDeal
//
//  Created by Priba on 2/22/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation

class FilterModel: Copying {
    var name: String = ""
    var gender: [Int] = []
    var ageFrom: Int = Constants.minAge
    var ageTo: Int = Constants.maxAge
    var distanceFrom: Double = 0
    var distanceTo: Double = 20000
    var langs: [LanguageModel] = [LanguageModel]()
    var countries: [CountryModel] = [CountryModel]()
    
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    var distance: Double = 0.0
    
    init(){}
    
    init(dict: NSDictionary) {
        
        if let tempDict = dict["location"] as? NSDictionary{
            if let temp = tempDict["lng"] as? Double{
                longitude = temp
            }
            
            if let temp = tempDict["lat"] as? Double{
                latitude = temp
            }
            
            if let temp = tempDict["distance"] as? Double{
                distance = temp
            }
        }
        
        if let temp = dict["gender"] as? [Int]{
            gender = temp
        }
        
        if let temp = dict["ageFrom"] as? Int{
            ageFrom = temp
        }
        
        if let temp = dict["ageTo"] as? Int{
            ageTo = temp
        }
        
        if let temp = dict["distanceFrom"] as? Double{
            distanceFrom = temp
        }
        
        if let temp = dict["distanceTo"] as? Double{
            distanceTo = temp
        }
        
        if let temp = dict["langs"] as? [NSDictionary]{
            for dict in temp{
                let lng = LanguageModel(dict: dict)
                langs.append(lng)
            }
        }
        
        if let temp = dict["countries"] as? [NSDictionary]{
            for dict in temp{
                let lng = CountryModel(dict: dict)
                countries.append(lng)
            }
        }
    }
    
    required init(original: FilterModel) {
        self.gender = original.gender
        self.ageFrom = original.ageFrom
        self.ageTo = original.ageTo
        self.distanceTo = original.distanceTo
        self.distanceFrom = original.distanceFrom
        self.longitude = original.longitude
        self.latitude = original.latitude
        self.distance = original.distance
        self.langs = original.langs
        self.countries = original.countries
        self.name = original.name
    }
    
    func copy(with zone: NSZone? = nil) -> FilterModel {
        return FilterModel(original: self)
    }
    
    func toDictionary() -> Dictionary<String, Any>{
        var dict = Dictionary<String, Any>()
        
        dict["name"] = self.name
        dict["gender"] = self.gender
        dict["ageFrom"] = self.ageFrom
        dict["ageTo"] = self.ageTo
        dict["langs"] = Utils.makeArrayOfLanguagesDict(array: self.langs)
        dict["countries"] = Utils.makeArrayOfCountriesDict(array: self.countries)

        return dict
    }
    
    func toDictionaryWithLangIds() -> Dictionary<String, Any>{
        var dict = Dictionary<String, Any>()
        
        dict["name"] = self.name
        dict["gender"] = self.gender
        dict["ageFrom"] = self.ageFrom
        dict["ageTo"] = self.ageTo
        dict["langs"] = Utils.makeArrayOfLanguagesDict(array: self.langs)
        dict["countries"] = Utils.makeArrayOfCountriesDict(array: self.countries)
        
        return dict
    }
    
    func toDictionaryWithLocation() -> Dictionary<String, Any>{
        var dict = Dictionary<String, Any>()
        
        dict["name"] = self.name
        dict["gender"] = self.gender
        dict["ageFrom"] = self.ageFrom
        dict["ageTo"] = self.ageTo
        dict["langs"] = Utils.makeArrayOfLanguagesDict(array: self.langs)
        dict["countries"] = Utils.makeArrayOfCountriesDict(array: self.countries)
        
        var locationDict = Dictionary<String, Any>()
        
        locationDict["lat"] = self.latitude
        locationDict["lng"] = self.longitude
        locationDict["distance"] = self.distance
        
        dict["location"] = locationDict
        
        return dict
    }
    
    func saveMainFilterToUserDefaults() {
        UserDefaults.standard.set(self.toDictionary(), forKey: "mainFilter")
    }
    
    func isClear() -> Bool {
        return countries.count == 0 && langs.count == 0 && gender.count == 0 && ageFrom == Constants.minAge && ageTo == Constants.maxAge
    }
    
   static func loadMainFilterFromUserDefaults() -> FilterModel {
        if let dict = UserDefaults.standard.value(forKey: "mainFilter") as? NSDictionary {
            return FilterModel(dict: dict)
        }
        return FilterModel()
    }
}
