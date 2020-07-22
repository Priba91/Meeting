//
//  UIViewControllerExtension.swift
//  Linguado
//
//  Created by Bojan Markovic on 05/09/2019.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}
