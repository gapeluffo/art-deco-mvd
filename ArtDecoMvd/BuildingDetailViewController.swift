//
//  BuildingDetailViewController.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 8/26/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit
import MapKit

class BuildingDetailViewController: UIViewController {
    
    @IBOutlet var buildingImage: UIImageView!
    @IBOutlet var buildingTitleLabel: UILabel!
    @IBOutlet var buildingArchitectLabel: UILabel!
    @IBOutlet var buildingMapView: MKMapView!
    @IBOutlet var buildingAddressLabel: UITextView!
    @IBOutlet var buildingAboutText: UITextView!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var buildingUseLabel: UILabel!

    var building: Building?
    var isFavorite : Bool = false
    let reuseIdentifier = "pin"

    override func viewDidLoad() {
        super.viewDidLoad()
        buildingMapView.delegate = self
        initializeLayout();
    }

    func initializeLayout(){

        if let building = self.building{

            // image
            if let image = self.building!.image{
                buildingImage.image = UIImage(named: image)
            }

            // title
            buildingTitleLabel.text = building.name.uppercaseString
            super.title = building.name

            // year - architect
            buildingArchitectLabel.text = "\(building.year) - \(building.architect)"
            buildingArchitectLabel.font = UIFont(name: kFontLight, size: 15)

            // address
            buildingAddressLabel.text = building.address

            // program
            if let program = building.program {
                buildingUseLabel.text = program
                buildingUseLabel.font = UIFont(name: kFontLight, size: 14)
            }

            // description
            buildingAboutText.text = building.fullDescription
            buildingUseLabel.font = UIFont(name: kFontLight, size: 14)

            // favorite star
            isFavorite = Favorites.sharedInstance.isFavorite(building)
            favoriteButton.setImage(UIImage(named: isFavorite ? Images.favorite : Images.notFavorite), forState: .Normal)

            // map pin
            addAnnotation(building)
        }

    }

    @IBAction func toggleFavorite(sender: AnyObject) {
        if let building = self.building {
            Favorites.sharedInstance.toggleFavorite(building)
            isFavorite = !isFavorite
            favoriteButton.setImage(UIImage(named: isFavorite ? Images.favorite : Images.notFavorite), forState: .Normal)
        }
    }
}

extension BuildingDetailViewController: MKMapViewDelegate{

    func addAnnotation(building:Building){

        let annotation = BuildingPinAnnotation()
        annotation.title = building.name
        annotation.subtitle = building.address
        annotation.coordinate = building.location

        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        buildingMapView.addAnnotation(annotationView.annotation!)

        let regionRadius: CLLocationDistance = 200
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(annotation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        buildingMapView.setRegion(coordinateRegion, animated: true)
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

        var auxView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        if(auxView == nil){
            auxView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            auxView!.canShowCallout = false
            auxView!.calloutOffset = CGPoint(x: -5, y: 5)
            auxView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            auxView!.image = UIImage(named: Images.mapPinDetails)
        }else{

            auxView!.annotation = annotation
        }
        
        return auxView
    }
}
