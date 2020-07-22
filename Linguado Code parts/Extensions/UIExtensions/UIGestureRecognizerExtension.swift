//
//  UIGestureRecognizerExtension.swift
//  Linguado
//
//  Created by Bojan Markovic on 03/09/2019.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation
import UIKit

extension UIGestureRecognizer {
    func cancel() {
        isEnabled = false
        isEnabled = true
    }
}
