//
//  SubActivitiesTableViewController.swift
//  iOSAppSwift
//
//  Created by raymond on 9/21/16.
//  Copyright © 2016 raymond. All rights reserved.
//  综合 - 活动

import UIKit

class SubActivitiesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
