//
//  Building.swift
//  ARTDeco
//
//  Created by Gabriela Peluffo on 8/21/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit
import MapKit

struct Building {

    var name: String
    var address: String
    var fullDescription: String
    var shortDescription: String
    var year: String
    var architect: String
    var location: CLLocationCoordinate2D
    
    static func loadBuildings() -> [Building]{
        let buildingList : [String:AnyObject] = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Buildings", ofType: "plist")!) as! [String:AnyObject]
        
        let buildings = buildingList["Buildings"] as! [[String:AnyObject]]
        
        return buildings.map{ (data:[String:AnyObject]) -> Building in
            return Building(
                name: data["name"] as! String,
                address: data["address"] as! String,
                fullDescription: "",
                shortDescription: "",
                year: data["year"] as! String,
                architect: data["author"] as! String,
                location: getCoordinates(data)
            )
        }
        
    }
    
    static func getCoordinates(buildingData:[String:AnyObject]) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: (buildingData["coordinates"]?["latitude"]?!.doubleValue)! , longitude: (buildingData["coordinates"]?["longitude"]?!.doubleValue)!)
    }
    
    
}
