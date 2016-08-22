//
//  SecondViewController.swift
//  ARTDeco
//
//  Created by Gabriela Peluffo on 8/21/16.
//  Copyright © 2016 Gabriela Peluffo. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    let buildingCellIdentifier = "BuildingCell"

    @IBOutlet var serachBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ListViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return BuildingTableViewCell()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
}

