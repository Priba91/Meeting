//
//  UserModel.swift
//  Linguado
//
//  Created by Priba on 2/26/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation
// Definicija connection statusa:
// -1: nismo prijatelji
// 0: poslao sam zahtev
// 1: user je meni poslao zahtev
// 2: konektovani smo
enum UserStatus {
    case notConnected
    case requestSent
    case pendingConnection
    case connected
}

class UserModel: Equatable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var age: Int = 0// Optional scalars not supported
    var city: String = ""
    var connectionStatus: UserStatus = .notConnected// Optional scalars not supported
    var country: String = ""
    var createdAt: String = ""
    var dateOfBirth: String = ""
    var distance: Int64 = -2 // Optional scalars not supported
    var email: String = ""
    var fullName: String = ""
    var gender: Int16 = 0 // Optional scalars not supported
    var id: Int64 = 0
    var conversationId: Int = 0
    var isBlocked: Bool = false// Optional scalars not supported
    var isBlockedMe: Bool = false// Optional scalars not supported
    var lat: Double = 0.0// Optional scalars not supported
    var lng: Double = 0.0// Optional scalars not supported
    var locale: String = ""
    var nextStop: String = ""
    var username: String = ""
    var helpPass: String = ""
    var isAgeVisible = false
    var isLocationVisible = false
    var isPushAllowed = false
    var loadedOnMap = false

    var avatars = [ImageModel]()
    var mainAvatar = ""
    var flag = ""

    var countryOrigin = CountryModel()
    var languages = [LanguageModel]()
    var desiredLanguages = [LanguageModel]()
    var desiredCountries = [CountryModel]()
    var settings = SettingsModel()
    var points = 0
    
    var isConnectionRequested = false
    
    var shareSelected = false
    
    init(){}
    
    init(dict: NSDictionary) {
        if let temp = dict["avatars"] as? [NSDictionary] {
            for dict in temp{
                let image = ImageModel(dict: dict)
                avatars.append(image)
            }
        }
        
        if let temp = dict["city"] as? String {
            city = temp
        }
        
        if let temp = dict["flag"] as? String {
            flag = temp
        }
        
        if let temp = dict["connectionStatus"] as? Int16 {
            switch temp {
            case -1: connectionStatus = .notConnected
            case 0: connectionStatus = .requestSent
            case 1: connectionStatus = .pendingConnection
            case 2: connectionStatus = .connected
            
            default: connectionStatus = .notConnected
            }
        }
        
        if let temp = dict["country"] as? String {
            country = temp
        }
        
        if let temp = dict["countryOrigin"] as? NSDictionary {
            countryOrigin = CountryModel(dict: temp)
        }
        
        if let temp = dict["createdAt"] as? String {
            createdAt = temp
        }
        
        if let temp = dict["dateOfBirth"] as? String {
            dateOfBirth = temp
            
            let dateRangeStart = Date()
            
            let formatter = DateFormatter()
            let myString = String(describing: dateOfBirth)
            formatter.dateFormat = "yyyy-MM-dd"
            let dateRangeEnd = formatter.date(from: myString)
            
            let components = Calendar.current.dateComponents([.year], from: dateRangeEnd ?? Date(), to: dateRangeStart)
            
            age = components.year ?? 0
        }
        
        if let temp = dict["desiredLangs"] as? [NSDictionary] {
            for dict in temp{
                let lang = LanguageModel(dict: dict)
                desiredLanguages.append(lang)
            }
        }
        
        if let temp = dict["desiredCountries"] as? [NSDictionary] {
            for dict in temp{
                let country = CountryModel(dict: dict)
                desiredCountries.append(country)
            }
        }
        
        if let temp = dict["email"] as? String {
            email = temp
        }
        
        if let temp = dict["fullName"] as? String {
            fullName = temp
        }
        
        if let temp = dict["gender"] as? Int16 {
            gender = temp
        }
        
        if let temp = dict["id"] as? Int64 {
            id = temp
        }
        
        if let temp = dict["conversationId"] as? Int {
            conversationId = temp
        }
        
        if let temp = dict["isAgeVisible"] as? Bool {
            isAgeVisible = temp
        }
        
        if let temp = dict["isBlocked"] as? Bool {
            isBlocked = temp
        }
        
        if let temp = dict["isBlockedMe"] as? Bool {
            isBlockedMe = temp
        }
        
        if let temp = dict["isVisibleOnMap"] as? Bool {
            isLocationVisible = temp
        }
        
        if let temp = dict["langs"] as? [NSDictionary] {
            for dict in temp{
                let lang = LanguageModel(dict: dict)
                languages.append(lang)
            }
        }
        
        if let temp = dict["distance"] as? Int64 {
            distance = temp
        }
        
        if let temp = dict["lat"] as? Double {
            lat = temp
        }
        
        if let temp = dict["lng"] as? Double {
            lng = temp
        }
        
        if let temp = dict["locale"] as? String {
            locale = temp
        }
        
        if let temp = dict["mainAvatar"] as? String {
            mainAvatar = temp
        }
        
        if let temp = dict["nextStop"] as? String {
            //TODO: Vidi da li je ovo stvarno string
            nextStop = temp
        }
        
        if let temp = dict["points"] as? Int {
            points = temp
        }
        
        if let temp = dict["settings"] as? NSDictionary {
            settings = SettingsModel(dict: temp)
        }
        
        if let temp = dict["username"] as? String {
            username = temp
        }
    }
    
    func getDistanceString()-> String {
        var str = ""
        
        let locale = Locale.current
        let isMetric = locale.usesMetricSystem
        
        if isMetric {
            if distance < 1000 {
                str = getRoundedDistance(distance: Float(distance)) + " m"
            } else {
                str = getRoundedDistance(distance: Float(distance/1000)) + " km"
            }
        } else {
            let foot: Float = Float(distance) * 3.28085
            
            if foot < 5280 {
                str = "\(Int(foot)) ft"
            } else {
                str = getRoundedDistance(distance: Float(foot)/5280) + " mi"
            }
        }
        
        return str
    }
    
    func getRoundedDistance(distance:Float) -> String {
        if distance.truncatingRemainder(dividingBy: 1) == 0  {
            //it's an integer
            return "\(Int(distance))"
        }
        else {
            //it's an double
            return String.init(format: "%.1f", distance)
        }
        
        
    }
    
    func toShortDictionary() -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
        
        dict["country"] = self.country
        dict["email"] = self.email
        dict["fullName"] = self.fullName
        dict["id"] = self.id
        dict["conversationId"] = self.conversationId
        dict["isBlocked"] = self.isBlocked
        dict["lat"] = self.lat
        dict["lng"] = self.lng
        dict["locale"] = self.locale
        dict["username"] = self.username
        
        return dict
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
        
        var array = [Dictionary<String, Any>]()
        for avatar in avatars {
            array.append(avatar.toDictionary())
        }
        
        dict["avatars"] = array
        dict["city"] = self.city
        dict["connectionStatus"] = self.connectionStatus
        dict["country"] = self.country
        dict["createdAt"] = self.createdAt
        dict["dateOfBirth"] = self.dateOfBirth
        dict["email"] = self.email
        dict["fullName"] = self.fullName
        dict["gender"] = self.gender
        dict["id"] = self.id
        dict["isAgeVisible"] = self.isAgeVisible
        dict["isBlocked"] = self.isBlocked
        dict["lat"] = self.lat
        dict["lng"] = self.lng
        dict["locale"] = self.locale
        dict["mainAvatar"] = self.mainAvatar
        dict["nextStop"] = self.nextStop
        dict["points"] = self.points
        dict["username"] = self.username
        dict["countryOrigin"] = self.countryOrigin.toDictionary()
        dict["conversationId"] = self.conversationId

        return dict
    }
}
