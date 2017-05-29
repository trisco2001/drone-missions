//
//  ServiceManager.swift
//  MapMissions
//
//  Created by Tristan Leonard on 5/29/17.
//  Copyright © 2017 Tristan Leonard. All rights reserved.
//

import Foundation

class ServiceManager {
    typealias MapControllerCreator = () -> MapControllerProtocol
    typealias LocationManagerCreator = () -> LocationManagerProtocol

    var mapController: MapControllerProtocol
    var locationManager: LocationManagerProtocol

    static var instance = ServiceManager(
        mapControllerCreator: ServiceManager.defaultMapControllerCreator(),
        locationManagerCreator: ServiceManager.defaultLocationManagerCreator()
    )

    private init(mapControllerCreator: MapControllerCreator, locationManagerCreator: LocationManagerCreator) {
        mapController = mapControllerCreator()
        locationManager = locationManagerCreator()
    }
}

extension ServiceManager {
    class func defaultMapControllerCreator() -> MapControllerCreator {
        return { DJIMapController() }
    }
    class func defaultLocationManagerCreator() -> LocationManagerCreator {
        return { BuiltInLocationManager() }
    }
}
