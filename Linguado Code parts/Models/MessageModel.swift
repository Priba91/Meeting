//
//  MessageModel.swift
//  Linguado
//
//  Created by Priba on 5/22/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation
import UIKit

enum MessageType {
    case chatDeny
    case chatRequest
    case chatAccepted
    case chatMessage
    case chatAudio
    case chatImage
    case linkPreview
    case profilePreview
}

class MessageModel: Copying {
    var body = ""
    var imageUrl = ""
    var conversationId: Int = 0
    var id: Int = 0
    var tempId: String = ""
    var receiver = UserModel()
    var seenAt = ""
    var sender = UserModel()
    var timePass: Double = 0.0
    var type = MessageType.chatMessage
    var uploadingImage = false
    var isDownloadingAudio = false
    var image: UIImage? = nil
    
    var audioDuration:Int = 0
    var audioUrl = ""
    var isPlayingAudio = false
    var isUploadingAudio = false
    var audioData: Data? = nil
    
    var audioPath : URL? = nil
    var audioLastPathComponent = ""
    var audioSeekSeconds: Float = 0.0
    
    var isDeleted = false
    
    var quoteMessage : MessageModel?
    
    var linkTitle = ""
    var linkImageUrl = ""
    var linkDesc = ""
    var linkShortUrl = ""
    var linkFullUrl = ""
    
    var sharedProfile = UserModel()
    
    required init(original: MessageModel) {
        self.body = original.body
        self.conversationId = original.conversationId
        self.id = original.id
        self.receiver = original.receiver
        self.seenAt = original.seenAt
        self.sender = original.sender
        self.timePass = original.timePass
        self.type = original.type
        
    }
    
    func copy(with zone: NSZone? = nil) -> MessageModel {
        return MessageModel(original: self)
    }

    init() {}
    
    init (dict: NSDictionary) {
        if let temp = dict["body"] as? String {
            body = temp
        }
        
        if let temp = dict["image"] as? String {
            imageUrl = temp
        }
        
        if let temp = dict["isDeleted"] as? Bool {
            isDeleted = temp
        }
        
        if let temp = dict["audioDuration"] as? Int {
            audioDuration = temp
        }
        
        if let temp = dict["audio"] as? String {
            audioUrl = temp
        }
        
        if let temp = dict["conversationId"] as? Int {
            conversationId = temp
        }
        
        if let temp = dict["receiver"] as? NSDictionary {
            receiver = UserModel(dict: temp)
        }
        
        if let temp = dict["quoteMessage"] as? NSDictionary {
            quoteMessage = MessageModel(dict: temp)
        }
        
        if let linkDict = dict["linkPreview"] as? NSDictionary {
            
            if let temp = linkDict["title"] as? String {
                linkTitle = temp
            }
            
            if let temp = linkDict["image"] as? String {
                linkImageUrl = temp
            }
            
            if let temp = linkDict["desc"] as? String {
                linkDesc = temp
            }
            
            if let temp = linkDict["url"] as? String {
                linkShortUrl = temp
            }
            
            if let temp = linkDict["fullUrl"] as? String {
                linkFullUrl = temp
            }
            
        }
        
        if let temp = dict["seenAt"] as? String {
            seenAt = temp
        }
        
        if let temp = dict["sender"] as? NSDictionary {
            sender = UserModel(dict: temp)
        }
        
        if let temp = dict["timePass"] as? Double {
            timePass = temp
        }
        
        if let temp = dict["id"] as? Int {
            id = temp
        }
        
        if let temp = dict["type"] as? Int {
            switch temp{
            case 0: type = .chatDeny
            case 1: type = .chatRequest
            case 2: type = .chatAccepted
            case 4: type = .chatMessage
            case 5: type = .chatAudio
            case 6: type = .chatImage

            default: type = .chatMessage
            }
        }
        
        if let linkDict = dict["linkPreview"] as? NSDictionary {
            
            type = .linkPreview
            
            if let temp = linkDict["title"] as? String {
                linkTitle = temp
            }
            
            if let temp = linkDict["image"] as? String {
                linkImageUrl = temp
            }
            
            if let temp = linkDict["desc"] as? String {
                linkDesc = temp
            }
            
            if let temp = linkDict["url"] as? String {
                linkShortUrl = temp
            }
            
            if let temp = linkDict["fullUrl"] as? String {
                linkFullUrl = temp
            }
            
        }
        
        if let temp = dict["profileShared"] as? NSDictionary {
            type = .profilePreview
            sharedProfile = UserModel(dict: temp)
        }
    }
    
    func toDictionary() -> Dictionary<String, Any>{
        var dict = Dictionary<String, Any>()
        
        dict["body"] = body
        dict["conversationId"] = self.conversationId
        dict["id"] = self.id
        dict["receiver"] = self.receiver.toShortDictionary()
        dict["seenAt"] = self.seenAt
        dict["sender"] = self.sender.toShortDictionary()
        dict["timePass"] = self.timePass
        dict["type"] = self.type.hashValue

        return dict
    }
    
    func getTimePassString() -> String {
        
        switch timePass {
        case -1:
            return LanguageManager.sharedInstance.getStringForKey(key: "sending")
        case 0:
            return LanguageManager.sharedInstance.getStringForKey(key: "now")
        default:
            break
        }
        
        let str = (timePass * 60).asString(style: .full)
        
        let arr = str.split(separator: ",")
        if arr.count > 0{
            return String(arr[0])
        }
        
        return str
    }
    
    func getAudioDurationString() -> String {
        let secondsSum = Int(audioDuration/1000)
        
        let minutes = Int(secondsSum/60)
        let seconds = secondsSum - minutes*60
        
        let str = String(format: "%02d:%02d", minutes, seconds)

        return str
    }
    
    func getMessageReplayString()-> String {
        
        switch type {
        case .chatAudio:
            return LanguageManager.sharedInstance.getStringForKey(key: "audio") + " \(getAudioDurationString())"
        case .chatMessage:
            return body
        case .chatImage:
            return LanguageManager.sharedInstance.getStringForKey(key: "image")
        default: return ""
        }
    }
    
    func getShortTimePassString()-> String {
        
        switch timePass {
        case -1:
            return LanguageManager.sharedInstance.getStringForKey(key: "sending")
        case 0:
            return LanguageManager.sharedInstance.getStringForKey(key: "now")
        default:
            break
        }

        if timePass > 60 {
            let calendar = Calendar.current
            let startDate = Date()
            let date = calendar.date(byAdding: .minute, value: Int(-timePass), to: startDate)
            let formater = DateFormatter()
            formater.dateFormat = "HH:mm"
            return formater.string(from: date ?? Date())
        }else{
            let str = (timePass * 60).asString(style: .short)
            
            let arr = str.split(separator: ",")
            if arr.count > 0{
                return String(arr[0])
            }
            
            return str

        }
    }

}

extension Array where Element: MessageModel {
    func stopAllAudio() {
        for element in self {
            element.isPlayingAudio = false
        }
    }
}

extension Double {
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.weekOfMonth, .day, .year, .month, .hour, .minute]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }
    
    func asTimeString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }
}
