//
//  AircraftAnnotation.swift
//  MapMissions
//
//  Created by Tristan Leonard on 5/29/17.
//  Copyright © 2017 Tristan Leonard. All rights reserved.
//

import Foundation
import MapKit

class AircraftAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D

    var annotationView: AircraftAnnotationView!

    init(withCoordinate coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }

    func update(withHeading heading: CGFloat) {
        guard let guardedAnnotationView = annotationView else {
            return
        }

        guardedAnnotationView.update(withHeading: heading)
    }
}
