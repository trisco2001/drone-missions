//
//  DJIMapController.swift
//  MapMissions
//
//  Created by Tristan Leonard on 5/28/17.
//  Copyright © 2017 Tristan Leonard. All rights reserved.
//

import UIKit
import MapKit

class DJIMapController: MapControllerProtocol {
    var editPoints: [CLLocation]

    init() {
        editPoints = [CLLocation]()
    }

    func add(point: CGPoint, withMapView mapView: MKMapView) {
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
    }

    func cleanAllPoints(mapView: MKMapView) {
        editPoints.removeAll()
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
}
