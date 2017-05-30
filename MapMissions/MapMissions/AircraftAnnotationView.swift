//
//  AircraftAnnotationView.swift
//  MapMissions
//
//  Created by Tristan Leonard on 5/29/17.
//  Copyright © 2017 Tristan Leonard. All rights reserved.
//

import Foundation
import MapKit

class AircraftAnnotationView: MKAnnotationView {
    override func awakeFromNib() {
        self.isEnabled = false
        self.isDraggable = false
        self.image = UIImage(named: "aircraft.png")
    }

    func update(withHeading heading: CGFloat) {
        self.transform = CGAffineTransform.identity
        self.transform.rotated(by: heading)
    }
}
