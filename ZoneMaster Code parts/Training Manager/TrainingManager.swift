//
//  TrainingManager.swift
//  PhysioZone
//
//  Created by Priba on 1/8/20.
//  Copyright © 2020 com.newtec-solutions.physiosone. All rights reserved.
//

import Foundation
import UIKit
import WatchConnectivity
import CoreLocation

class TrainingManager {
    
    public static let shared = TrainingManager()
    public var locationManager = CLLocationManager()

    var isTrainingON: Bool = false
    var currentTraining: TrainingModeModel? = nil
    
    var stopTrainingTimer = Timer()
    
    var numberOfTrainingsToday = 0
    var updateCalories = true
        
    private init() {

        NotificationCenter.default.addObserver(self, selector: #selector(finishedEnterTrainingPrametars(notification:)), name: NSNotification.Name(rawValue: "finishedEnterTrainingPrametars"), object: nil)
    }
        
    func fetchCurrentTraining(){
        currentTraining = CDManager.shared.fetchCurrentTraining()
        
        if currentTraining == nil {
            isTrainingON = false
        }else{
            isTrainingON = currentTraining?.startDate == currentTraining?.endDate
        }
        
        continueFetchedTraining()
        
        var dic: [String : Any] = ["isTrainingStarted" : TrainingManager.shared.isTrainingON]
        
        if TrainingManager.shared.isTrainingON && TrainingManager.shared.currentTraining?.startDate != nil {
            dic["training_start_date"] = TrainingManager.shared.currentTraining!.startDate
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendStopTrainigNotification"), object: nil, userInfo: dic)
    }
    
    @objc func finishedEnterTrainingPrametars(notification: NSNotification){
                
        guard let coefficient = notification.userInfo!["coefficient"] as? Int else {
            return
        }
        
        guard let mediaTypeInt = notification.userInfo!["mediaTypeInt"] as? Int else {
            return
        }
        
        guard let activityType = notification.userInfo!["activityType"] as? String else {
            return
        }
        
        isTrainingON = true
        
        let newTraining = TrainingModeModel(inputParametarsCoefficient: coefficient, mediaTypeInt: mediaTypeInt, activityType: activityType)
        newTraining.mediaTypeInt = mediaTypeInt
        CDManager.shared.addNewTraining(inputTraining: newTraining)
        currentTraining = newTraining
        notifyTrainingStateChanged()
        Calculator.calculateZoneValues()
        addNewTrainingNumber()
    }
    
    func changeTrainingStateFromViewController(vc: UIViewController){
                
        if isTrainingON {
            stopTraining()
        }else{
            
            startTrainingFromViewController(vc: vc)
        }
    }
    
    func startTrainingFromViewController(vc: UIViewController) {
        
        currentTraining = CDManager.shared.fetchCurrentTraining()
        CDManager.shared.addDailyUser()
        
        if currentTraining == nil && !((currentTraining?.endDate.isPassLessThen15Minutes()) ?? false){
            let popup =  UIStoryboard(name: "TrainingParameters", bundle: nil).instantiateViewController(withIdentifier: "TrainingParametarsViewController") as! TrainingParametarsViewController
                    
            vc.present(popup, animated: false, completion: nil)
        }else{
            isTrainingON = true
            currentTraining!.endDate = currentTraining!.startDate
            stopTrainingTimer.invalidate()
            CDManager.shared.updateTraining(training: currentTraining!)
            notifyTrainingStateChanged()
            Calculator.calculateZoneValues()

        }
    }
    
    func continueFetchedTraining(){
        guard currentTraining != nil else{
            return
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "checkPlayBtnState"), object: nil)
        
        if currentTraining?.startDate != currentTraining?.endDate {
            setAutomaticalyFinishTrainingIfNeeded()
            return
        }
        
        notifyTrainingStateChanged()
    }
    
    func stopTraining(endDateTimestamp: Double? = nil){
        locationManager.stopUpdatingLocation()

        guard currentTraining != nil else{
            return
        }
        
        isTrainingON = false
        
        currentTraining?.endDate = Date().localDate()
        
        if endDateTimestamp != nil {
            currentTraining?.endDate = Date(timeIntervalSince1970: endDateTimestamp!)
        }
        
        CDManager.shared.updateTraining(training: currentTraining!)
        setAutomaticalyFinishTrainingIfNeeded()

        Calculator.calculateZoneValues()
        notifyTrainingStateChanged()

    }
    
    func setAutomaticalyFinishTrainingIfNeeded(){
        guard currentTraining != nil && currentTraining?.endDate != nil && currentTraining?.endDate.isPassLessThen15Minutes() ?? false else{
            return
        }
        let stopingPassedSeconds = Int(Date().localDate().timeIntervalSince(currentTraining!.endDate))
        stopTrainingTimer.invalidate()
                                                                            //900 = 15 min in seconds
        stopTrainingTimer = Timer.scheduledTimer(timeInterval: (TimeInterval(900 - stopingPassedSeconds)), target: self, selector: #selector(automaticalyFinishTraining), userInfo: nil, repeats: false)
    }
    
    @objc func automaticalyFinishTraining(){
        currentTraining?.finished = true
        CDManager.shared.updateTraining(training: currentTraining!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "checkPlayBtnState"), object: nil)
    }
    
    func notifyTrainingStateChanged(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "trainingStateChanged"), object: nil)
    }
    
    func fetchNumberOfTrainingsToday(){
        if let dict = UserDefaults.standard.dictionary(forKey: "numberOfTrainingsToday") as NSDictionary? {
            let date = dict["date"] as! Date
            
            if date.isInSameDayAs(date: Date().localDate().setOnDayStart()!) {
                if let num  = dict["numberOfTrainings"] as? Int {
                    numberOfTrainingsToday = num
                }
                
            }else{
                numberOfTrainingsToday = 0
                UserDefaults.standard.set(["date" : Date().localDate().setOnDayStart()!, "numberOfTrainings" : Int(0)], forKey: "numberOfTrainingsToday")
            }
        }else{
            UserDefaults.standard.set(["date" : Date().localDate().setOnDayStart()!, "numberOfTrainings" : Int(0)], forKey: "numberOfTrainingsToday")
        }
    }
    
    func addNewTrainingNumber(){
        if let dict = UserDefaults.standard.dictionary(forKey: "numberOfTrainingsToday") as NSDictionary? {
            let date = dict["date"] as! Date
            
            if date.isInSameDayAs(date: Date().localDate().setOnDayStart()!) {
                var trainings = 0
                if let num  = dict["numberOfTrainings"] as? Int {
                    trainings = num
                }
                trainings += 1
                numberOfTrainingsToday = trainings
                UserDefaults.standard.set(["date" : Date().localDate().setOnDayStart()!, "numberOfTrainings" : trainings], forKey: "numberOfTrainingsToday")
                
            }else{
                numberOfTrainingsToday = 1
                UserDefaults.standard.set(["date" : Date().localDate().setOnDayStart()!, "numberOfTrainings" : 1], forKey: "numberOfTrainingsToday")
            }
        }else{
            UserDefaults.standard.set(["date" : Date().localDate().setOnDayStart()!, "numberOfTrainings" : 1], forKey: "numberOfTrainingsToday")
        }
    }
}
