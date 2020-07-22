//
//  DataManager.swift
//  JobDeal
//
//  Created by Priba on 12/7/18.
//  Copyright © 2018 Priba. All rights reserved.
//

import Foundation
import GoogleMaps

class DataManager{
    static let sharedInstance = DataManager()

    var registrationUser = UserModel()
    var logedUser = UserModel()
    var userLastLocation = CLLocationCoordinate2D()
    
    var mainFilter = FilterModel.loadMainFilterFromUserDefaults()
    
    var foodTypes = [FoodType]()
    var tags = [TagModel]()
    
    var currency = "RSD"
    
    private var loadCount = 0
    
    func loadAddresses(){
        //TODO: REFACTOR
//        logedUser.selectedAddress = AddressModel(dict: UserDefaults.standard.object(forKey: "selectedAddress") as? NSDictionary ?? [:])
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateAddressBar"), object: nil)

//        ServerManager.sharedInstance.getAllAddresses { (response, success, errMsg) in
//            self.loadCount += 1
//
//            if success! {
//
//                for dict in response {
//                    let add = AddressModel(dict: dict)
//                    if add.id == self.selectedAddress.id{
//                        add.selected = true
//                    }
//                    //add.selected = add.id == self.selectedAddress.id
//
//                    self.userAddresses.append(AddressModel(dict: dict))
//                }
//
//            }else{
//                if self.loadCount < 3 {
//                    self.loadAddresses()
//                }
//            }
//        }
    }
    
    func selectAddress(address:AddressModel){
        
        guard let index = logedUser.addresses.firstIndex(where: { $0.id == address.id}) else{
            return
        }
        logedUser.addresses.deselectAll()
        logedUser.addresses[index].selected = true
        logedUser.selectedAddress = logedUser.addresses[index]
        
        ServerManager.sharedInstance.selectAddress(address: logedUser.addresses[index]) { (response, success, errMsg) in
            
        }
        
        //UserDefaults.standard.set(logedUser.addresses[index].toDictionary(), forKey: "selectedAddress")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateAddressBar"), object: nil)
    }
    
    func addNewAddress(address:AddressModel){
        self.logedUser.addresses.deselectAll()
        address.selected = true
        logedUser.selectedAddress = address
        logedUser.addresses.append(address)
        UserDefaults.standard.set(address.toDictionary(), forKey: "selectedAddress")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateAddressBar"), object: nil)
    }
    
    func addressUpdated(address:AddressModel){
        
        guard let index = logedUser.addresses.firstIndex(where: { $0.id == address.id}) else{
            return
        }
        
        logedUser.addresses[index] = address
    }
    
    func addressDeleted(address:AddressModel){
        
        guard let index = logedUser.addresses.firstIndex(where: { $0.id == address.id}) else{
            return
        }
        
        logedUser.addresses.remove(at: index)
        
        if logedUser.addresses.count > 0{
            selectAddress(address: logedUser.addresses[0])
        }
    }
    
    func loadTypes(dict: NSDictionary){
        foodTypes.removeAll()
        tags.removeAll()

        if let types = dict["foodTypes"] as? [NSDictionary], let tags = dict["tags"] as? [NSDictionary] {
            
            for dict in tags {
                let tmp = TagModel(dict: dict)
                self.tags.append(tmp)
            }
            
            for dict in types {
                let tmp = FoodType(dict: dict)
                self.foodTypes.append(tmp)
            }
        }
    }
    
}
