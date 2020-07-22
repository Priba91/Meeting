//
//  ShadowMaterialView.swift
//  ManGO
//
//  Created by Priba on 9/2/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation
import MaterialComponents

class ShadowMaterialView: MDCCard {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadowElevation(ShadowElevation(3), for: .normal)
    }
}

class ShadowMaterialUpsideDownView: MDCCard {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadowElevation(ShadowElevation(3), for: .normal)
        self.alpha = 0.7
        self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
}

class ShadowMaterialUpsideDownSharpView: MDCCard {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setShadowElevation(ShadowElevation(2), for: .normal)
        self.cornerRadius = 0
        self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
}
