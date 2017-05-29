//
//  DJIRootViewController.swift
//  MapMissions
//
//  Created by Tristan Leonard on 5/28/17.
//  Copyright © 2017 Tristan Leonard. All rights reserved.
//

import UIKit
import MapKit
import DJISDK

class DJIRootViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var editButton: UIButton!

    var mapController: MapControllerProtocol!
    var tapGesture: UITapGestureRecognizer!
    var isEditingPoints: Bool = false

    override func viewDidLoad() {
        // Initialization
        mapController = ServiceManager.instance.mapController
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(addWayPoint))

        mapView.addGestureRecognizer(tapGesture)
    }
    @IBAction func editButtonAction(_ sender: Any) {
        if isEditingPoints {
            mapController.cleanAllPoints(mapView: mapView)
            editButton.setTitle("Edit", for: .normal)
        } else {
            editButton.setTitle("Reset", for: .normal)
        }

        self.isEditingPoints = !self.isEditingPoints
    }

    func addWayPoint(tapGesture: UITapGestureRecognizer) {
        let point = tapGesture.location(in: mapView)

        if tapGesture.state == .ended && isEditingPoints {
            mapController?.add(point: point, withMapView: mapView)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation is MKPointAnnotation {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin_Annotation")
            pinView.pinTintColor = UIColor.purple
            return pinView
        }

        return nil
    }
}
