//
//  MapControllerProtocol.swift
//  MapMissions
//
//  Created by Tristan Leonard on 5/29/17.
//  Copyright © 2017 Tristan Leonard. All rights reserved.
//

import Foundation
import MapKit

protocol MapControllerProtocol {
    var editPoints: [CLLocation] { get set }

    func add(point: CGPoint, withMapView mapView: MKMapView)

    func cleanAllPoints(mapView: MKMapView)
}
