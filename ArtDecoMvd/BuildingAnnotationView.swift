//
//  BuildingMapAnnotation.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 8/21/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//
import UIKit
import MapKit

class BuildingAnnotationView : UIView {

    @IBOutlet var image: UIImageView!
    @IBOutlet var buildingName: UILabel!
    @IBOutlet var buildingAddress: UILabel!
    @IBOutlet var favoriteButton: UIButton!

    var isFavorite: Bool = false
    var isSelected: Bool = false

    func toggleFavorite() {
        let image = UIImage(named: isFavorite ? Images.favoriteSmaller : Images.notFavoriteSmaller)
        favoriteButton.setImage(image, forState: .Normal)
    }

    @IBAction func morite(sender: AnyObject) {
        
    }

    @IBAction func goToDetails(sender: AnyObject) {

    }
    
    @IBAction func ahowDetails(sender: AnyObject) {

    }

    func configure(building: BuildingPinAnnotation){
        buildingName.text    = building.title!
        buildingAddress.text = building.subtitle!

        self.layer.cornerRadius = 15

        isFavorite = building.isFavorite
        favoriteButton.setImage(UIImage(named: isFavorite ? Images.favoriteSmaller : Images.notFavoriteSmaller), forState: .Normal)
        favoriteButton.userInteractionEnabled = true
    }

    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, withEvent: event)
        if (hitView != nil) {
            self.superview?.bringSubviewToFront(self)
        }
        return hitView
    }

    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        let rect = self.bounds
        var isInside = CGRectContainsPoint(rect, point)
        if (!isInside) {
            for view in self.subviews {
                isInside = CGRectContainsPoint(view.frame, point)
                if (isInside) {

                }
            }
        }
        return isInside
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        let calloutViewController = MapViewController(nibName: "CalloutView", bundle: nil)
//
//        if selected {
//
//            calloutViewController.view.clipsToBounds = true
//            calloutViewController.view.layer.cornerRadius = 10
//            calloutViewController.view.center = CGPointMake(self.bounds.size.width * 0.5, -calloutViewController.view.bounds.size.height * 0.5)
//            self.addSubview(calloutViewController.view)
//
//
//        } else {
//            // Dismiss View
//            calloutViewController.view.removeFromSuperview()
//        }
//    }
}
