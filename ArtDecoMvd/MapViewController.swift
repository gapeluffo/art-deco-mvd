//
//  FirstViewController.swift
//  ARTDeco
//
//  Created by Gabriela Peluffo on 8/21/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    let regionRadius: CLLocationDistance = 1000
    let initialLocation = CLLocation(latitude: -34.911025, longitude: -56.163031)

    @IBOutlet weak var mapView: MKMapView!
    let reuseIdentifier = "pin"

    var buildings : [Building] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.mainColor
        
        mapView.delegate = self
        centerMapOnLocation(initialLocation)
        buildings = Building.loadBuildings()
        addPins()
    }

}

extension MapViewController {
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addPins(){
        
        var annotation      : MKPointAnnotation
        var annotationView  : MKAnnotationView
        
        for building in buildings{
            annotation = MKPointAnnotation()
            annotation.title = building.name
            annotation.subtitle = building.address
            annotation.coordinate = building.location
            
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            mapView.addAnnotation(annotationView.annotation!)
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var v = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        if(v == nil){
            v = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            v!.canShowCallout = true
            v!.calloutOffset = CGPoint(x: -5, y: 5)
            v!.image = UIImage(named: "Pin")
            v!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure) as UIView
        }else{
            v!.annotation = annotation
        }
        return v

    }
    
    
    
}
