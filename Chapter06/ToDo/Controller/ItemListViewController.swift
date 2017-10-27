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
  @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate & ItemManagerSettable)!
  let itemManager = ItemManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = dataProvider
    tableView.delegate = dataProvider
    
    dataProvider.itemManager = itemManager
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(showDetails(sender:)),
      name: NSNotification.Name("ItemSelectedNotification"),
      object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()
  }
  
  @IBAction func addItem(_ sender: UIBarButtonItem) {
    
    if let nextViewController =
      storyboard?.instantiateViewController(
        withIdentifier: "InputViewController")
        as? InputViewController {
      
      nextViewController.itemManager = itemManager
      
      present(nextViewController, animated: true, completion: nil)
    }
  }
  
  @objc func showDetails(sender: NSNotification) {
    guard let index = sender.userInfo?["index"] as? Int else
    { fatalError() }
    
    
    if let nextViewController = storyboard?.instantiateViewController(
      withIdentifier: "DetailViewController") as? DetailViewController {
      
      
      nextViewController.itemInfo = (itemManager, index)
      navigationController?.pushViewController(nextViewController,
                                               animated: true)
    }
  } 
}
