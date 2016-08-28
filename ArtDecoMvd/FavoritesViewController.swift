//
//  FavoritesViewController.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 8/26/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController{
    
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var thisView: UIView!
    @IBOutlet var tableView: UITableView!
    
    var favorites : [Building] = []
    let favoriteCell = "FavCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thisView.backgroundColor = Colors.mainColor
        navBar.barTintColor = Colors.mainColor
        navBar.tintColor = UIColor.whiteColor()
        navBar.titleTextAttributes = NavBar.navBarSettings
        
        tableView.delegate = self
        tableView.dataSource = self
        
        initializeFavorites()
    }
    
    override func viewWillAppear(animated: Bool) {
        initializeFavorites()
        tableView.reloadData()
    }
    
    func initializeFavorites(){
        favorites = Building.loadBuildings().filter{ building in
            return Favorites.sharedInstance.isFavorite(building)
        }
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(favoriteCell, forIndexPath: indexPath) as! BuildingTableViewCell
        
        cell.configure(favorites[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 157
    }
}
