//
//  InboxModel.swift
//  Linguado
//
//  Created by Priba on 5/22/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation


class InboxModel: Copying {
    
    var id: Int = 0
    var lastSender = UserModel()
    var latestMessage = MessageModel()
    var name = ""
    var seen = ""
    var sender = UserModel()
    var unread = 0
    
    required init(original: InboxModel) {
        self.id = original.id
        self.lastSender = original.lastSender
        self.latestMessage = original.latestMessage
        self.name = original.name
        self.seen = original.seen
        self.sender = original.sender
        
    }
    
    func copy(with zone: NSZone? = nil) -> InboxModel {
        return InboxModel(original: self)
    }
    
    init() {}
    
    init (dict: NSDictionary){
        
        if let temp = dict["id"] as? Int {
            id = temp
        }
        
        if let temp = dict["unread"] as? Int {
            unread = temp
        }
        
        if let temp = dict["lastReceiver"] as? NSDictionary {
            lastSender = UserModel(dict: temp)
        }
        
        if let temp = dict["latestMessage"] as? NSDictionary {
            latestMessage = MessageModel(dict: temp)
        }
        
        if let temp = dict["name"] as? String {
            name = temp
        }
        
        if let temp = dict["sender"] as? NSDictionary {
            sender = UserModel(dict: temp)
        }
        
        if let temp = dict["seen"] as? String {
            seen = temp
        }
    }
    
    func toDictionary() -> Dictionary<String, Any>{
        var dict = Dictionary<String, Any>()
        
        dict["id"] = id
        dict["lastReceiver"] = self.lastSender.toShortDictionary()
        dict["name"] = self.name
        dict["seen"] = self.seen
        dict["sender"] = self.sender.toShortDictionary()
        
        return dict
    }
    
}
