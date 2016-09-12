//
//  Favorites.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 8/26/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit

class Favorites {

    var favoriteBuildings : [Int] = []
    private let favIdentifier = "Favs"
    
    init(){
        let defaults = NSUserDefaults.standardUserDefaults()
        favoriteBuildings = defaults.objectForKey(favIdentifier) as? [Int] ?? [Int]()
    }
    
    
    // --------    Singleton    ------------
    struct Static {
        static var instance: Favorites?
    }
    
    class var sharedInstance : Favorites{
        if (Static.instance == nil){
            Static.instance = Favorites()
        }
        return Static.instance!
    }
    // -------------------------------------
    
    
    func getFavorites() -> [Building]{
        return Building.allBuildings.filter { (building:Building) -> Bool in
            return favoriteBuildings.contains(building.id)
        }
    }
    
    func addFavorite(building:Building){
        if(favoriteBuildings.contains(building.id)){
            return
        }
        favoriteBuildings.append(building.id)
    }
    
    func removeFavorite(building:Building){
        if(!favoriteBuildings.contains(building.id)){
            return
        }
        
        let index = favoriteBuildings.indexOf(building.id)
        favoriteBuildings.removeAtIndex(index!)
    }
    
    func toggleFavorite(building:Building){
        favoriteBuildings.contains(building.id) ? removeFavorite(building) : addFavorite(building)
        saveFavorites()
    }
    
    
    func isFavorite(building:Building) -> Bool{
        return favoriteBuildings.contains(building.id)
    }

    func saveFavorites(){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favoriteBuildings, forKey: favIdentifier)
    }

    
}
