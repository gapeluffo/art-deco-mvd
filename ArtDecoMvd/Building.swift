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

    private enum BuildingKeys : String {
      case Name = "name"
      case Address = "address"
      case ShortDesc = "shortDescription"
      case FullDesc = "fullDescription"
      case Year = "year"
      case Author = "author"
      case Coordinates = "coordinates"
      case Latitude = "latitude"
      case Longitude = "longitude"
    }
  
    var name: String
    var address: String
    var fullDescription: String
    var shortDescription: String
    var year: String
    var architect: String
    var location: CLLocationCoordinate2D

    static func loadBuildings() -> [Building]{
        let buildingList : [String:AnyObject] = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource(kBuildingsKey, ofType: "plist")!) as! [String:AnyObject]

        let buildings = buildingList[kBuildingsKey] as! [[String:AnyObject]]

        return buildings.map{ (data:[String:AnyObject]) -> Building in
            return Building(
                name: data[BuildingKeys.Name.rawValue] as! String,
                address: data[BuildingKeys.Address.rawValue] as! String,
                fullDescription: "",
                shortDescription: "",
                year: data[BuildingKeys.Year.rawValue] as! String,
                architect: data[BuildingKeys.Author.rawValue] as! String,
                location: getCoordinates(data[BuildingKeys.Coordinates.rawValue] as! [String : AnyObject])
            )
        }
    }

    static func getCoordinates(buildingData:[String:AnyObject]) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: (buildingData[BuildingKeys.Latitude.rawValue]!.doubleValue)!,
                                     longitude: (buildingData[BuildingKeys.Longitude.rawValue]!.doubleValue)!)
    }
    
}
