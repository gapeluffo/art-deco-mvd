//
//  LocationSearchTableViewController.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 10/26/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit
import MapKit

protocol LocationSearchDelegate {
    func buildingSelected(building:Building)
}

class LocationSearchTableViewController : UITableViewController {

    var matchingBuildings : [Building] = []
    var buildingsList     : [Building] = []
    var delegate          : LocationSearchDelegate!

    override func viewDidLoad() {
        buildingsList = Building.loadBuildings()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingBuildings.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let building = matchingBuildings[indexPath.row]

        cell.textLabel!.text = building.name
        cell.detailTextLabel!.text = building.address

        cell.textLabel?.font = UIFont(name: kFontMedium, size: 17)
        cell.detailTextLabel?.font = UIFont(name: kFontLight, size: 14)

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if delegate != nil {
            let building = matchingBuildings[indexPath.row]
            dismissViewControllerAnimated(true, completion: nil)
            delegate.buildingSelected(building)
        }
    }

}

extension LocationSearchTableViewController : UISearchResultsUpdating {

    func updateSearchResultsForSearchController(searchController: UISearchController) {

        if searchController.searchBar.text! == "" {
            matchingBuildings = []
        }else{
            matchingBuildings = buildingsList.filter { building in
                let searchTextLower = searchController.searchBar.text!.lowercaseString
                return building.name.lowercaseString.containsString(searchTextLower) ||
                       building.address.lowercaseString.containsString(searchTextLower)
            }
        }

        tableView.reloadData()
    }
}
