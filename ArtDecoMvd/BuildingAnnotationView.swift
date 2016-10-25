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

    var isFavorite: Bool = false

    func toggleFavorite() {
        let image = UIImage(named: isFavorite ? Images.favoriteSmaller : Images.notFavoriteSmaller)
        favoriteButton.setImage(image, forState: .Normal)
    }

    @IBAction func goToDetails(sender: AnyObject) {
    }

    func configure(building: BuildingPinAnnotation){
        buildingName.text    = building.title!
        buildingAddress.text = building.subtitle!

        self.layer.cornerRadius = 15

        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(toggleFavorite))
        tap.numberOfTapsRequired = 1
        tap.delegate = self

        isFavorite = building.isFavorite
        favoriteButton.setImage(UIImage(named: isFavorite ? Images.favoriteSmaller : Images.notFavoriteSmaller), forState: .Normal)
        favoriteButton.addGestureRecognizer(tap)
        favoriteButton.userInteractionEnabled = true
    }
}
