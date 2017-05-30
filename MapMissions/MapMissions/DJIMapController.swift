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
    var aircraftAnnotation: AircraftAnnotation!

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
            if !(annotation is AircraftAnnotation) {
                mapView.removeAnnotation(annotation)
            }
        }
    }

    func update(withAircraftLocation aircraftLocation: CLLocationCoordinate2D, andMapView mapView: MKMapView) {
        if aircraftAnnotation == nil {
            aircraftAnnotation = AircraftAnnotation(withCoordinate: aircraftLocation)
            mapView.addAnnotation(aircraftAnnotation)
        } else {
            aircraftAnnotation.coordinate = aircraftLocation
        }
    }

    func update(withAircraftHeading aircraftHeading: CGFloat) {
        guard let guardedAnnotation = aircraftAnnotation else {
            return
        }

        guardedAnnotation.update(withHeading: aircraftHeading)
    }
}
