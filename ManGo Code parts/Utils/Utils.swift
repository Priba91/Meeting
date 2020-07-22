//
//  Utils.swift
//  JobDeal
//
//  Created by Priba on 12/7/18.
//  Copyright © 2018 Priba. All rights reserved.
//

import Foundation
import UIKit
import AdSupport
import FirebaseDynamicLinks

class Utils{
    
    static func isIphoneSeriesX()-> Bool{
        
        if(UIApplication.shared.keyWindow!.frame.height >= CGFloat(812.0)){
            return true
        }
        return false
    }
    
    static func isIphoneSmallSeries()-> Bool{
        
        if(UIApplication.shared.keyWindow!.frame.height <= CGFloat(568.0)){
            return true
        }
        return false
    }
    
    static func isValidEmail(enteredEmail:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: enteredEmail)
    }
    
    static func getStringWidth(str: String, font: UIFont) -> CGFloat{
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (str as NSString).size(withAttributes: fontAttributes)
        return size.width 
    }
    
    static func getMoodFromRate(rate:Double)-> String{
        
        switch Int(rate) {
        case 0:
            return LanguageManager.sharedInstance.getStringForKey(key: "poor")
        case 2:
            return LanguageManager.sharedInstance.getStringForKey(key: "fair")
        case 3:
            return LanguageManager.sharedInstance.getStringForKey(key: "good")
        case 4:
            return LanguageManager.sharedInstance.getStringForKey(key: "very_good")
        case 5:
            return LanguageManager.sharedInstance.getStringForKey(key: "excellent")
        default:
            return LanguageManager.sharedInstance.getStringForKey(key: "excellent")
        }
    }

    static func makeArrayOfAddressDict(array:[AddressModel]) -> [[String:Any]]{
        var output = [[String:Any]]()
        
        for lng in array {
            output.append(lng.toDictionary())
        }
        
        return output
    }
    
    static func makeArrayOfFoodTypesDict(array:[FoodType]) -> [[String:Any]]{
        var output = [[String:Any]]()
        
        for lng in array {
            output.append(lng.toDictionary())
        }
        
        return output
    }
    
    static func makeArrayOfFoodTypesIDs(array:[FoodType]) -> [Int]{
        var output = [Int]()
        
        for lng in array {
            output.append(lng.id)
        }
        
        return output
    }
    
    static func makeArrayOfAditionItemsDict(array:[AditionItemModel]) -> [[String:Any]]{
        var output = [[String:Any]]()
        
        for lng in array {
            output.append(lng.toDictionary())
        }
        
        return output
    }
    
    static func makeArrayOfMenuItemsDict(array:[MenuItem]) -> [[String:Any]]{
        var output = [[String:Any]]()
        
        for lng in array {
            output.append(lng.toDictionary())
        }
        
        return output
    }
    
    static func makeArrayOfTagsDict(array:[TagModel]) -> [[String:Any]]{
        var output = [[String:Any]]()
        
        for lng in array {
            output.append(lng.toDictionary())
        }
        
        return output
    }
    
    static func makeArrayOfAditionItemDict(array:[AdditionMenuItemModel]) -> [[String:Any]]{
        var output = [[String:Any]]()
        
        for lng in array {
            output.append(lng.toDictionary())
        }
        
        return output
    }
    
    static func updateFilterSortBy(filter:FilterModel){
        let udSort = UserDefaults.standard.object(forKey: "selectedSort") as? String ?? ""

        switch udSort {
        case LanguageManager.sharedInstance.getStringForKey(key: "sort_by_fresh"):
            filter.sortBy = ""
            filter.sortDirection = ""
        case LanguageManager.sharedInstance.getStringForKey(key: "my_favorite"):
            filter.sortBy = "isFavorite"
            filter.sortDirection = "desc"
            
        case LanguageManager.sharedInstance.getStringForKey(key: "new"):
            filter.sortBy = "numberOfFavorites"
            filter.sortDirection = "desc"
            
        case LanguageManager.sharedInstance.getStringForKey(key: "rate"):
            filter.sortBy = "averageRate"
            filter.sortDirection = "desc"
            
        case LanguageManager.sharedInstance.getStringForKey(key: "rate_count"):
            filter.sortBy = "numberOfFavorites"
            filter.sortDirection = "asc"
            
        case LanguageManager.sharedInstance.getStringForKey(key: "cheepest"):
            filter.sortBy = "averagePrice"
            filter.sortDirection = "asc"
            
        case LanguageManager.sharedInstance.getStringForKey(key: "most_expensive"):
            filter.sortBy = "averagePrice"
            filter.sortDirection = "desc"
            
        case LanguageManager.sharedInstance.getStringForKey(key: "nearest"):
            filter.sortBy = "distance"
            filter.sortDirection = "desc"
            
        case LanguageManager.sharedInstance.getStringForKey(key: "farest"):
            filter.sortBy = "distance"
            filter.sortDirection = "asc"
            
        case LanguageManager.sharedInstance.getStringForKey(key: "popular"):
            filter.sortBy = "isPopular"
            filter.sortDirection = "asc"
            
        default:
            break
        }
        
        
    }
    
    static func getPriceString(price: Double) -> String {
        let currency = DataManager.sharedInstance.currency
        
        if price.truncatingRemainder(dividingBy: 1) == 0 {
            //it's an integer
            return "\(Int(price)) \(currency)"
        }
        else {
            //it's an double
            return "\(Double(round(100*price)/100)) \(currency)"
        }
    }
        
}
