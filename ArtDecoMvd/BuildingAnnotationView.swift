//
//  BuildingMapAnnotation.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 8/21/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//
import UIKit
import MapKit

class BuildingAnnotationView : UIView, UIGestureRecognizerDelegate {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var buildingName: UILabel!
    @IBOutlet var buildingAddress: UILabel!
    
    @IBOutlet var favoriteButton: UIButton!
    
    func toggleFavorite(recognizer: UITapGestureRecognizer) {
        isFavorite = !isFavorite
        let image = UIImage(named: isFavorite ? "fav_selected" : "fav")
        favoriteButton.setImage(image, forState: .Normal)
    }
    
    @IBAction func goToDetails(sender: AnyObject) {
        
    }
    
    var isFavorite: Bool = false
    
    func configure(building: MKAnnotation){
        buildingName.text    = building.title!
        buildingAddress.text = building.subtitle!
        
        self.layer.cornerRadius = 15
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleFavorite))
        tap.delegate = self
        favoriteButton.addGestureRecognizer(tap)
        favoriteButton.userInteractionEnabled = true
    }
    
}
