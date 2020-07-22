//
//  UIImagePickerProtocolExtension.swift
//  Linguado
//
//  Created by Bojan Markovic on 15/10/2019.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation
import CropViewController

extension UIImagePickerProtocol where Self: UIViewController {
    var croppingStyle: CropViewCroppingStyle{
        return CropViewCroppingStyle.default
    }
    func importImage(_ sender: Any) {
    }
}
