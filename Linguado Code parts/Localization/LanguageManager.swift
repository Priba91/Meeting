//
//  LanguageManager.swift
//  JobDeal
//
//  Created by Priba on 12/7/18.
//  Copyright © 2018 Priba. All rights reserved.
//

import Foundation

class LanguageManager{
    
    static let sharedInstance = LanguageManager()
    
    public func getStringForKey(key:String, uppercased:Bool = false)-> String{
        
        var path = Bundle.main.path(forResource: getLanguageExtension(), ofType: "lproj")
        
        if path == nil {
            path = Bundle.main.path(forResource: "en", ofType: "lproj")
        }
        
        let langBundle = Bundle.init(path: path!)
        let str = langBundle?.localizedString(forKey: key, value: "", table: nil)
        
        if(uppercased){
            return str?.uppercased() ?? ""
        }
        
        return str ?? ""
        
    }
    
    public func getLanguageExtension()-> String{
            
        if let langStr = UserDefaults.standard.object(forKey: "language_str") as? String{
            return langStr.lowercased()
            
        }else{
            let language = Locale.preferredLanguages.first
            let languageDict = Locale.components(fromIdentifier: language ?? "")
            var languageCode = languageDict["kCFLocaleLanguageCodeKey"]
            
            if languageCode == "pt" { //REFACTOR
                languageCode = "pt-PT"
            }
            
            return languageCode ?? ""
        }
        
    }
    
    
}
