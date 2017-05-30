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

class DJIRootViewController: UIViewController, MKMapViewDelegate, LocationManagerDelegate, DJISDKManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var mode: UILabel!
    @IBOutlet weak var gps: UILabel!
    @IBOutlet weak var hsLabel: UILabel!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var altLabel: UILabel!

    var mapController: MapControllerProtocol!
    var locationManager: LocationManagerProtocol!

    var tapGesture: UITapGestureRecognizer!
    var isEditingPoints: Bool = false
    var userLocation = CLLocation()

    override func viewDidLoad() {
        // Initialization
        mapController = ServiceManager.instance.mapController
        locationManager = ServiceManager.instance.locationManager
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(addWayPoint))

        mapView.addGestureRecognizer(tapGesture)

        locationManager.delegate = self

        mode.text = "N/A"
        gps.text = "0"
        vsLabel.text = "0.0 M/S"
        hsLabel.text = "0.0 M/S"
        altLabel.text = "0 M"

        if !DJISDKManager.hasSDKRegistered() {
            DJISDKManager.registerApp(with: self)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        locationManager.startUpdateLocation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdateLocation()
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

    func locationServicesUnavailable() {
        let alert = UIAlertController(
            title: "No Location Available",
            message: "Locations services are not available, sorry.",
            preferredStyle: .alert
        )
        alert.show(self, sender: nil)
    }

    func currentLocationChanged(location: CLLocation) {

    }

    @IBAction func focusTapped(_ sender: Any) {
        if locationManager.currentLocation != CLLocation() {
            let region = MKCoordinateRegion(
                center: locationManager.currentLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))

            mapView.setRegion(region, animated: true)
        }

    }

    func appRegisteredWithError(_ error: Error?) {
        if error != nil {
            NSLog("%@", error?.localizedDescription ?? "")
        }
    }

    func productConnected(_ product: DJIBaseProduct?) {
        if product != nil {

        }
    }
}
