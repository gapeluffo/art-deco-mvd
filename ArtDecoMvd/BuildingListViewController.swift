//
//  EdificiosViewController.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 8/25/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit

class BuildingListViewController: UIViewController {

    private enum TableOption : Int{
        case ByBuilding = 0
        case ByAuthor   = 1
    }

    @IBOutlet var optionsTabView: UIView!
    @IBOutlet var buildingFilter: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var thisView: UIView!
    @IBOutlet var searchButton: UIBarButtonItem!
    @IBOutlet var buildingGroupOptions: UISegmentedControl!
    @IBOutlet var buildingGroupOptionView: UIView!
    
    let buildingCellIdentifier      = "BuildingCell"
    
    private var filteredBuildings     : [Building] = []
    private var buildingsList         : [Building] = []
    private var buildingsByAuthor     : [String:[Building]]?
    private var buildingsByAuthorKeys : [String] = []
    private var builingListType       : TableOption = TableOption.ByBuilding
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad();

        setupBuildingsUI()
        setupSearchController()

        // load buildings
        buildingsList = Building.loadBuildings().sort({ $0.name < $1.name })
        buildingsByAuthor = groupBuildingsByAuthor()

        tableView.delegate = self
        tableView.dataSource = self

    }


//  -----------------------   events     ---------------------------------

    @IBAction func showSearchBar(sender: AnyObject) {
        toggleSearchBar(false)
    }

    func toggleSearchBar(hide: Bool){
        let frame : CGRect = hide ? CGRectMake(0, 0, 320, 0.0) : CGRectMake(0, 0, 320, 44)

        UIView.animateWithDuration(0.3) {
            self.searchController.searchBar.frame = frame
            self.tableView.tableHeaderView = hide ? nil : self.searchController.searchBar
        }
    }

    @IBAction func buildingGroupOptionValueChanged(sender: UISegmentedControl) {
        builingListType = TableOption(rawValue: sender.selectedSegmentIndex)!
        tableView.reloadData()
    }


//  -----------------------   layout     ---------------------------------

    private func setupSearchController() {
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.backgroundColor = Colors.mainColor
        searchController.searchBar.barTintColor = Colors.mainColor
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.translucent = false
        searchController.searchBar.delegate = self

        //SearchBar Text
        let textFieldInsideUISearchBar = searchController.searchBar.valueForKey("searchField") as? UITextField

        //SearchBar Placeholder
        let textFieldInsideUISearchBarLabel = textFieldInsideUISearchBar!.valueForKey("placeholderLabel") as? UILabel
        textFieldInsideUISearchBarLabel?.text = "Buscar"
        textFieldInsideUISearchBarLabel?.font = UIFont(name: kFontLight, size: 14)

        searchController.searchBar.setValue("Cancelar", forKey:"_cancelButtonText")

    }

    private func setupBuildingsUI() {
        buildingGroupOptionView.backgroundColor = Colors.mainColor
        buildingGroupOptions.backgroundColor = Colors.mainColor
        buildingGroupOptions.setTitleTextAttributes(Fonts.segmentedControlFont, forState: .Normal)
        thisView.backgroundColor = Colors.mainColor
    }


}

extension BuildingListViewController : UISearchResultsUpdating, UISearchBarDelegate {

    //--------------------------------------------------------------------------------------
    //                                  SEARCH BAR
    //--------------------------------------------------------------------------------------

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

    //--------------------------------------------------------------------------------------
    //                                  TABLE SECTIONS
    //--------------------------------------------------------------------------------------

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if isSearch() {
            return filteredBuildings.count
        }else if builingListType == TableOption.ByBuilding {
            return buildingsList.count
        }else{
            let key = buildingsByAuthorKeys[section]
            return (buildingsByAuthor![key]?.count)!
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return isSearch() ? 1 : (builingListType == TableOption.ByBuilding ? 1 : buildingsByAuthor!.keys.count)
    }


    //--------------------------------------------------------------------------------------
    //                                  TABLE HEADER
    //--------------------------------------------------------------------------------------

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !isSearch() && builingListType == TableOption.ByAuthor {
            return 30
        }
        return 0
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !isSearch() && builingListType == TableOption.ByAuthor {
            return buildingsByAuthorKeys[section].uppercaseString
        }
        return ""
    }

    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView

        header.textLabel!.textColor = Colors.mainColor50
        header.textLabel!.font = UIFont(name: kFontMedium, size: 14)
        header.textLabel!.frame = header.frame
    }


    //--------------------------------------------------------------------------------------
    //                                  TABLE CELLS
    //--------------------------------------------------------------------------------------

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(buildingCellIdentifier, forIndexPath: indexPath) as! BuildingTableViewCell

        cell.configure(getBuildingByIndexPath(indexPath))
        return cell
    }

}

extension BuildingListViewController{

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell,
            indexPath = tableView.indexPathForCell(cell),
            buildindDetailViewController = segue.destinationViewController as? BuildingDetailViewController
        {
            buildindDetailViewController.building = getBuildingByIndexPath(indexPath)
        }
    }

    func getBuildingByIndexPath(indexPath:NSIndexPath) -> Building{

        if isSearch() {
            return filteredBuildings[indexPath.row]
        }else if builingListType == TableOption.ByBuilding {
            return buildingsList[indexPath.row]
        }else{
            let key = buildingsByAuthorKeys[indexPath.section]
            return buildingsByAuthor![key]![indexPath.row]
        }
    }

    private func groupBuildingsByAuthor() -> [String:[Building]]{
        var list = [String:[Building]]()

        for building in buildingsList {
            let key = building.architect == "" ? "Otros" : building.architect

            if !list.keys.contains(key){
                list[key] = []
            }

            list[key]?.append(building)
        }

        buildingsByAuthorKeys = Array(list.keys)
        buildingsByAuthorKeys.sortInPlace({
            $0 < $1 || $1 == "Otros"
        })

        buildingsByAuthorKeys.map { (key) in
            list[key]!.sort({ $0.name < $1.name })
        }
        return list
    }
}
