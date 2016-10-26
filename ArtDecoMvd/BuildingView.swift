//
//  BuildingMapAnnotation.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 8/21/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//
import UIKit
import MapKit

class BuildingView : UIView {

    @IBOutlet var image: UIImageView!
    @IBOutlet var buildingName: UILabel!
    @IBOutlet var buildingAddress: UILabel!
    @IBOutlet var favoriteButton: UIButton!

    var building: Building?
    var isFavorite: Bool = false
    var isSelected: Bool = false

    @IBAction func favoriteTouchUp(sender: AnyObject) {

        Favorites.sharedInstance.toggleFavorite(building!)

        isFavorite = !isFavorite
        favoriteButton.setImage(UIImage(named: isFavorite ? Images.favoriteSmaller : Images.notFavoriteSmaller), forState: .Normal)
    }

    @IBAction func detailsTouchUp(sender: AnyObject) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let detailsController = storyBoard.instantiateViewControllerWithIdentifier("buildingDetailViewController") as! BuildingDetailViewController
        detailsController.building = building
        self.presentView

    }

    func configure(building: BuildingPinAnnotation){
        self.building = building.building
        buildingName.text    = building.title!
        buildingAddress.text = building.subtitle!

        self.layer.cornerRadius = 15

        isFavorite = building.isFavorite
        favoriteButton.setImage(UIImage(named: isFavorite ? Images.favoriteSmaller : Images.notFavoriteSmaller), forState: .Normal)
        favoriteButton.userInteractionEnabled = true

        buildingAddress.font = UIFont(name: kFontLight, size: 11)
        buildingName.font = UIFont(name: kFontMedium, size: 13)
    }
}
