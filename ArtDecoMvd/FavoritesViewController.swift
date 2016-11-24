//
//  FavoritesViewController.swift
//  ArtDecoMvd
//
//  Created by Gabriela Peluffo on 8/26/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class FavoritesViewController: UIViewController{

    @IBOutlet var thisView: UIView!
    @IBOutlet var tableView: UITableView!
    
    var favorites : [Building] = []
    let favoriteCell = "FavCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thisView.backgroundColor = Colors.mainColor
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()

        initializeFavorites()
    }
    
    override func viewWillAppear(animated: Bool) {
        initializeFavorites()
        tableView.reloadData()
    }
    
    func initializeFavorites(){
        favorites = Building.loadBuildings()
            .filter{ building in
                return Favorites.sharedInstance.isFavorite(building)
            }.sort({
                $0.name < $1.name
            })
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
        let building = favorites[indexPath.row]

        if let image = building.image {
            return CGFloat(image == Images.noImage ? kBuildingCellHeightNoImage : kBuildingCellHeight)
        }else{
            return CGFloat(kBuildingCellHeightNoImage)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UITableViewCell,
            indexPath = tableView.indexPathForCell(cell),
            buildindDetailViewController = segue.destinationViewController as? BuildingDetailViewController
        {
            buildindDetailViewController.building = favorites[indexPath.row]
        }
    }
}

extension FavoritesViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{

    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "star")
    }

    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "No tiene favoritos"
        let attribs = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(18),
            NSForegroundColorAttributeName: UIColor.darkGrayColor()
        ]

        return NSAttributedString(string: text, attributes: attribs)
    }

    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Puede marcar sus edificios favoritos desde el mapa o el listado"

        let para = NSMutableParagraphStyle()
        para.lineBreakMode = NSLineBreakMode.ByWordWrapping
        para.alignment = NSTextAlignment.Center

        let attribs = [
            NSFontAttributeName: UIFont.systemFontOfSize(14),
            NSForegroundColorAttributeName: UIColor.lightGrayColor(),
            NSParagraphStyleAttributeName: para
        ]

        return NSAttributedString(string: text, attributes: attribs)
    }

}
