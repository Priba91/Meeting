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
    
    static func isIphoneSeriesX() -> Bool {
        if UIApplication.shared.keyWindow!.frame.height >= CGFloat(812.0) {
            return true
        }
        
        return false
    }
    
    static func isIphoneSmallSeries() -> Bool {
        if UIApplication.shared.keyWindow!.frame.width <= CGFloat(320) {
            return true
        }
        
        return false
    }
    
    static func isValidEmail(enteredEmail:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: enteredEmail)
    }
    
    static func makeArrayOfLanguagesDict(array:[LanguageModel]) -> [[String:Any]]{
        var output = [[String:Any]]()
        
        for lng in array {
            output.append(lng.toDictionary())
        }
        
        return output
    }
    
    static func makeArrayOfUsersIds(array:[UserModel]) -> [Int]{
        var output = [Int]()
        
        for lng in array {
            output.append(Int(lng.id))
        }
        
        return output
    }
    
    static func makeArrayOfCountriesDict(array:[CountryModel]) -> [[String:Any]]{
        var output = [[String:Any]]()
        
        for lng in array {
            output.append(lng.toDictionary())
        }
        
        return output
    }
    
    static func getStringWidth(str: String, font: UIFont) -> CGFloat{
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (str as NSString).size(withAttributes: fontAttributes)
        return size.width 
    }
    
    static func addNotificationCount(){
        var count = UserDefaults.standard.integer(forKey: "notificationsCount")
        count += 1
        UIApplication.shared.applicationIconBadgeNumber = count
        UserDefaults.standard.set(count, forKey: "notificationsCount")
        
        NotificationCenter.default.post(name: NSNotification.Name("updateChatCounter"), object: nil)
    }
    
    static func divideNotificationCount(amount: Int){
        
        var count = UserDefaults.standard.integer(forKey: "notificationsCount")
        count -= abs(amount)
        
        if count < 0 {
            count = 0
        }
        
        UIApplication.shared.applicationIconBadgeNumber = count
        
        UserDefaults.standard.set(count, forKey: "notificationsCount")
        
        NotificationCenter.default.post(name: NSNotification.Name("updateChatCounter"), object: nil)
    }
    
    static func getUrlsArray(avatars: [ImageModel]) -> [String]{
        var array = [String]()
        
        for img in avatars {
            array.append(img.fullUrl)
        }
        
        return array
    }
 
}
