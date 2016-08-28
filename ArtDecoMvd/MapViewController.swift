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

    private enum PinOptions : Int{
        case All        = 0
        case Favorties  = 1
    }

    @IBOutlet var optionsTab: UIView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var mapOptions: UISegmentedControl!
    
    let regionRadius: CLLocationDistance = 1000
    let reuseIdentifier = "pin"

    var buildings : [Building] = []
    var allAnnotations : [MKAnnotation] = []
    

    
    
    //    TODOOOOO SET THIS TO USERS CURRENT LOCATION
    let initialLocation = CLLocation(latitude: -34.911025, longitude: -56.163031)
    //    TODOOOOO SET THIS TO USERS CURRENT LOCATION

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLayout()
        mapView.delegate = self
        
        buildings = Building.loadBuildings()
        addPins()
        
    }
    

    
    @IBAction func pinOptionsChanged(sender: AnyObject) {
        if mapOptions.selectedSegmentIndex == PinOptions.All.rawValue {
            mapView.addAnnotations(filterAnnotations(true))

        }else{
            mapView.removeAnnotations(filterAnnotations(false))
        }
    }
    

    func initializeLayout(){
        self.view.backgroundColor = Colors.mainColor
        optionsTab.backgroundColor = Colors.mainColor
        centerMapOnLocation(initialLocation)
    }

    func filterAnnotations(favorites:Bool) -> [MKAnnotation]{
        let annotations = allAnnotations
        let filteredAnnotations = annotations.filter({ (annotation: MKAnnotation) -> Bool in
            let buildingAnnotation = annotation as! BuildingPinAnnotation
            return buildingAnnotation.isFavorite == favorites
        })
        return filteredAnnotations
    }
}


extension MapViewController : MKMapViewDelegate {
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func addPins(){
        
        var annotation      : BuildingPinAnnotation
        var annotationView  : MKAnnotationView
        
        for building in buildings{
            annotation = BuildingPinAnnotation()
            annotation.title = building.name
            annotation.subtitle = building.address
            annotation.coordinate = building.location
            annotation.isFavorite = Favorites.sharedInstance.isFavorite(building)
            
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            mapView.addAnnotation(annotationView.annotation!)
            allAnnotations.append(annotationView.annotation!)
        }
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var auxView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        if(auxView == nil){
            let buildingAnnotation = annotation as! BuildingPinAnnotation
            auxView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            auxView!.canShowCallout = false
            auxView!.calloutOffset = CGPoint(x: -5, y: 5)
            auxView!.image = UIImage(named: buildingAnnotation.isFavorite ? "map_pin_favorite" : "map_pin")
            auxView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }else{
            auxView!.annotation = annotation
        }

        return auxView
    }

    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if view.annotation is MKUserLocation{
            return
        }
        
        let annotation = view.annotation! as! BuildingPinAnnotation
        var buildingView = NSBundle.mainBundle().loadNibNamed("BuildingAnnotationView", owner: nil, options: nil)[0] as! BuildingAnnotationView

        view.addSubview(buildingView)

        buildingView.configure(annotation)
        buildingView.center = CGPointMake(view.bounds.size.width / 2, -buildingView.bounds.size.height*0.72)

        buildingView = view.subviews[0] as! BuildingAnnotationView
        buildingView.buildingAddress.font = UIFont(name: kFontLight, size: 11)
        buildingView.buildingName.font = UIFont(name: kFontMedium, size: 13)
    }

    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        
        if view.isKindOfClass(MKAnnotationView){
            for subview in view.subviews{
                subview.removeFromSuperview()
            }
        }
    }
}

