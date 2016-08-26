//
//  EdificiosViewController.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 8/25/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit

class EdificiosViewController: UIViewController {
    
    @IBOutlet var optionsTabView: UIView!
    @IBOutlet var buildingFilter: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var thisView: UIView!
    @IBOutlet var searchButton: UIBarButtonItem!
    
    let searchController = UISearchController(searchResultsController: nil)
    var buildingsList : [Building] = []
    let buildingCellIdentifier = "BuildingCell"
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        optionsTabView.backgroundColor = Colors.mainColor
        buildingFilter.backgroundColor = Colors.mainColor
        thisView.backgroundColor = Colors.mainColor
        
        
        //  Search bar initializers
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = Colors.mainColor
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.translucent = false
        searchController.searchBar.delegate = self
        
        // table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // load buildings
        buildingsList = Building.loadBuildings()
    }
    

    func toggleSearchBar(hide: Bool){
        let frame : CGRect = hide ? CGRectMake(0, 0, 320, 0.0) : CGRectMake(0, 0, 320, 44)
        
        UIView.animateWithDuration(0.3) { 
            self.searchController.searchBar.frame = frame
            self.tableView.tableHeaderView = hide ? nil : self.searchController.searchBar
        }
    }
    
    @IBAction func showSearchBar(sender: AnyObject) {
        toggleSearchBar(false)
    }
}

extension EdificiosViewController : UISearchResultsUpdating {
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

}

extension EdificiosViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        toggleSearchBar(true)
    }
}

extension EdificiosViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        // go to details
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildingsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(buildingCellIdentifier, forIndexPath: indexPath) as! BuildingTableViewCell
        
        cell.configure(buildingsList[indexPath.row])
        
        return cell
        
    }
    
}


