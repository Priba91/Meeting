//
//  TextViewExtension.swift
//  JobDeal
//
//  Created by Priba on 1/9/19.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    func setupForDarkLayout(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.separatorColor.cgColor
        self.layer.cornerRadius = 8
                
        self.contentInset = UIEdgeInsets(top: 8,left: 24,bottom: 8,right: 24)
    }
    
}
