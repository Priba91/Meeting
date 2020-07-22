//
//  ArrayExtension.swift
//  Linguado
//
//  Created by Bojan Markovic on 18/09/2019.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation
import Alamofire

let arrayParametersKey = "arrayParametersKey"

/// Extenstion that allows an array be sent as a request parameters
extension Array {
    /// Convert the receiver array to a `Parameters` object.
    func asParameters() -> Parameters {
        return [arrayParametersKey : self]
    }
}
