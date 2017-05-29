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

    var mapController: MapControllerProtocol

    static var instance = ServiceManager(
        mapControllerCreator: ServiceManager.defaultMapControllerCreator()
    )

    private init(mapControllerCreator: MapControllerCreator) {
        mapController = mapControllerCreator()
    }

    public class func setup(
        mapControllerCreator: MapControllerCreator = ServiceManager.defaultMapControllerCreator()
    ) -> ServiceManager {
        instance = ServiceManager(mapControllerCreator: mapControllerCreator)
        return instance
    }
}

extension ServiceManager {
    class func defaultMapControllerCreator() -> MapControllerCreator {
        return { DJIMapController() }
    }
}
