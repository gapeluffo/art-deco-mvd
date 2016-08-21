//
//  FirstViewController.swift
//  ARTDeco
//
//  Created by Gabriela Peluffo on 8/21/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    let regionRadius: CLLocationDistance = 1000
    let initialLocation = CLLocation(latitude: -34.911025, longitude: -56.163031)

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(initialLocation)
    }

}

extension MapViewController {
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
