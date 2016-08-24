//
//  BuildingMapAnnotation.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 8/21/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//
import UIKit
import MapKit

class BuildingAnnotationView : UIView{
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var buildingName: UILabel!
    @IBOutlet var buildingAddress: UILabel!
    
    @IBAction func goToDetails(sender: AnyObject) {
    }
    
    func configure(building: MKAnnotation){
        buildingName.text    = building.title!
        buildingAddress.text = building.subtitle!
    }
    
}
