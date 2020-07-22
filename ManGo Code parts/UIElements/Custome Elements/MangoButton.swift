//
//  MangoButton.swift
//  ManGO
//
//  Created by Priba on 6/21/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

class MangoButton: UIButton {
    
    override class var layerClass: AnyClass {
        return MDCShadowLayer.self
    }
    
    var shadowLayer: MDCShadowLayer {
        return self.layer as! MDCShadowLayer
    }
    
    func setDefaultElevation() {
        self.shadowLayer.elevation = .init(rawValue: 3)
    }
    
    func setupBottomWhiteStyle(){

        self.dropShadow4()
        self.backgroundColor = .white
        self.setTitleColor(.mangoGreen, for: .normal)
    }
    
    func setupBottomGreenStyle(){

        self.dropShadow4()
        self.backgroundColor = .mangoGreen
        self.setTitleColor(.white, for: .normal)
    }
    
    func enableButton(){
        self.isUserInteractionEnabled = true
        self.backgroundColor = .mangoGreen
    }
    
    func disableButton(){
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
    }
}
