//
//  UserLocation.swift
//  Linguado
//
//  Created by Bojan Markovic on 13/09/2019.
//  Copyright © 2019 Priba. All rights reserved.
//

import Foundation
import CoreLocation

final class UserLocation {
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Double
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Double) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
}
