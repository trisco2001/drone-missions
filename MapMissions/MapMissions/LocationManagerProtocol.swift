//
//  LocationManagerProtocol.swift
//  MapMissions
//
//  Created by Tristan Leonard on 5/29/17.
//  Copyright © 2017 Tristan Leonard. All rights reserved.
//

import Foundation
import MapKit

protocol LocationManagerDelegate: class {
    func locationServicesUnavailable()

    func currentLocationChanged(location: CLLocation)
}

protocol LocationManagerProtocol {
    func startUpdateLocation()

    func stopUpdateLocation()

    var currentLocation: CLLocation {get}

    weak var delegate: LocationManagerDelegate? {get set}
}
