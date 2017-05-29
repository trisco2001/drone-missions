//
//  BuiltInLocationManager.swift
//  MapMissions
//
//  Created by Tristan Leonard on 5/29/17.
//  Copyright © 2017 Tristan Leonard. All rights reserved.
//

import Foundation
import MapKit

class BuiltInLocationManager: NSObject, LocationManagerProtocol, CLLocationManagerDelegate {

    var currentLocation: CLLocation
    var locationManager: CLLocationManager!
    weak var delegate: LocationManagerDelegate?

    override init() {
        currentLocation = CLLocation()
    }

    func startUpdateLocation() {
        if CLLocationManager.locationServicesEnabled() {
            if locationManager == nil {
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.distanceFilter = 0.1
                locationManager.requestAlwaysAuthorization()
                locationManager.startUpdatingLocation()
            }
        } else {
            delegate?.locationServicesUnavailable()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            currentLocation = locations[0]
        }
        delegate?.currentLocationChanged(location: currentLocation)
    }

    func stopUpdateLocation() {
        locationManager.stopUpdatingLocation()
        locationManager = nil
    }
}
