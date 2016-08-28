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

    var id: Int
    var name: String
    var address: String
    var fullDescription: String
    var shortDescription: String
    var year: String
    var architect: String
    var location: CLLocationCoordinate2D
    
    static var allBuildings : [Building] = []
    
    static func loadBuildings() -> [Building]{
        
        if(allBuildings.count > 0){
            return allBuildings
        }
        
        let buildingList : [String:AnyObject] = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("Buildings", ofType: "plist")!) as! [String:AnyObject]
        
        let buildings = buildingList["Buildings"] as! [String:[String:AnyObject]]
        
        return buildings.keys.map{ (id:String) -> Building in
            let building = buildings[id]! as [String:AnyObject]
            return Building(
                id: Int(id)!,
                name: building["name"] as! String,
                address: building["address"] as! String,
                fullDescription: "",
                shortDescription: "",
                year: building["year"] as! String,
                architect: building["author"] as! String,
                location: getCoordinates(building)
            )
        }
        
    }
    
    
    static func getCoordinates(buildingData:[String:AnyObject]) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: (buildingData["coordinates"]?["latitude"]?!.doubleValue)! , longitude: (buildingData["coordinates"]?["longitude"]?!.doubleValue)!)
    }
    
}
