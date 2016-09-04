//
//  EdificiosViewController.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 8/25/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit

class BuildingListViewController: UIViewController {
    
    @IBOutlet var optionsTabView: UIView!
    @IBOutlet var buildingFilter: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var thisView: UIView!
    @IBOutlet var searchButton: UIBarButtonItem!
    
    let buildingCellIdentifier      = "BuildingCell"
    
    var filteredBuildings   : [Building] = []
    var buildingsList       : [Building] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad();

        setupBuildingsUI()
        setupSearchController()

        // load buildings
        buildingsList = Building.loadBuildings().sort({ $0.name < $1.name })

        tableView.delegate = self
        tableView.dataSource = self

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

    private func setupSearchController() {
      definesPresentationContext = true
      searchController.searchResultsUpdater = self
      searchController.dimsBackgroundDuringPresentation = false
      searchController.searchBar.barTintColor = Colors.mainColor
      searchController.searchBar.tintColor = UIColor.whiteColor()
      searchController.searchBar.translucent = false
      searchController.searchBar.delegate = self
    }

    private func setupBuildingsUI() {
//      optionsTabView.backgroundColor = Colors.mainColor
//      buildingFilter.backgroundColor = Colors.mainColor
      thisView.backgroundColor = Colors.mainColor
    }
}

extension BuildingListViewController : UISearchResultsUpdating, UISearchBarDelegate {

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        if searchText == "" {
            filteredBuildings = buildingsList
        }else{
            filteredBuildings = buildingsList.filter { building in
                return building.name.lowercaseString.containsString(searchText.lowercaseString) || building.architect.lowercaseString.containsString(searchText.lowercaseString)
            }
        }

        tableView.reloadData()
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        toggleSearchBar(true)
    }

    func isSearch() -> Bool {
        return searchController.active && searchController.searchBar.text != ""
    }
}



extension BuildingListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearch() ? filteredBuildings.count : buildingsList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(buildingCellIdentifier, forIndexPath: indexPath) as! BuildingTableViewCell
        
        cell.configure(getBuildingByIndexPath(indexPath))
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell,
               indexPath = tableView.indexPathForCell(cell),
               buildindDetailViewController = segue.destinationViewController as? BuildingDetailViewController
        {
            buildindDetailViewController.building = getBuildingByIndexPath(indexPath)
        }
    }

    func getBuildingByIndexPath(indexPath:NSIndexPath) -> Building{
        return isSearch() ? filteredBuildings[indexPath.row] : buildingsList[indexPath.row]
    }
}
