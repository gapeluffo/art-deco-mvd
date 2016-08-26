//
//  BuildingTableViewCell.swift
//  ARTDeco
//
//  Created by Maxi Casal on 7/31/16.
//  Copyright © 2016 MaxiCasal. All rights reserved.
//

import UIKit

class BuildingTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    var isFavorite: Bool = false
    
    @IBAction func favoriteClicked(sender: AnyObject) {
        isFavorite = !isFavorite
        favoriteButton.setImage(UIImage(named: isFavorite ? "fav_selectedx2" : "favx2"), forState: .Normal)
    }
    
    func configure(building:Building){
        nameLabel.text = building.name
        descriptionLabel.text = "\(building.year) - \(building.architect)"
        
        nameLabel.font = UIFont(name: "Avenir-Heavy", size: 18)
        descriptionLabel.font = UIFont(name: "Avenir-Medium", size: 15)
    }
}
