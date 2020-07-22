//
//  NPPhoneValidator.swift
//  NasaPatrola
//
//  Created by Priba on 5/14/18.
//  Copyright © 2018 Nemanja Krstic. All rights reserved.
//

import Foundation
import PhoneNumberKit
import CoreTelephony

@objc class NPPhoneValidator: NSObject{
    static let sharedInstance = NPPhoneValidator()
    private override init() {}
    
    let phoneNumberKit = PhoneNumberKit()

    @objc func validateNumber(countryCode: String, number: String)-> Dictionary<String, Any>{
        
        do {
            let phoneNumberCustomDefaultRegion = try phoneNumberKit.parse(number, withRegion: getContryCodeForNumericCode(numericCode: countryCode), ignoreType: false)
            return ["success":true,
                    "countryCode":phoneNumberCustomDefaultRegion.countryCode,
                    "phoneNumber":phoneNumberCustomDefaultRegion.nationalNumber]
        }
        catch {
            return ["success":false]
        }

    }
    
    @objc func getCurrentCountryCode()-> String{
        if let ipCode = UserDefaults.standard.value(forKey: "ipCountryCode") as? String{
            return ipCode.uppercased()
        }else{
            return ""
        }
    }
    
    @objc func getNumericCountryCode()-> String{
        
        var countryCode = ""
        
        let carrier = CTTelephonyNetworkInfo.init().subscriberCellularProvider
        if let code = carrier?.isoCountryCode {
            countryCode = code;
        }else{
            countryCode = getCurrentCountryCode()
        }
        
        if let code = phoneNumberKit.countryCode(for: countryCode){
            return String(describing: code)
        }else{
            return ""
        }
    }
    
    @objc func getContryCodeForNumericCode(numericCode: String)-> String{
        if numericCode != "", let numCodeInt = UInt64(numericCode){
            if let code = phoneNumberKit.mainCountry(forCode: numCodeInt){
                return String(describing: code)
            }else{
                return ""
            }
        }else{
            return ""
        }
    }

    
}

