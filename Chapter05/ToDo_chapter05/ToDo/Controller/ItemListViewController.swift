//
//  ItemListViewController.swift
//  ToDo
//
//  Created by dasdom on 25.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

  @IBOutlet var tableView: UITableView!
  @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = dataProvider
    tableView.delegate = dataProvider
  }
}
