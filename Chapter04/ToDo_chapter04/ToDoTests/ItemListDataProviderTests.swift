//
//  ItemListDataProviderTests.swift
//  ToDoTests
//
//  Created by dasdom on 25.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListDataProviderTests: XCTestCase {
  
  var sut: ItemListDataProvider!
  var tableView: UITableView!
  var controller: ItemListViewController!
  
  override func setUp() {
    super.setUp()
    
    sut = ItemListDataProvider()
    sut.itemManager = ItemManager()
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    controller = storyboard.instantiateViewController(
      withIdentifier: "ItemListViewController") as! ItemListViewController
    
    controller.loadViewIfNeeded()
    
    tableView = controller.tableView
    tableView.dataSource = sut
    tableView.delegate = sut
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test_NumberOfSections_IsTwo() {
    let numberOfSections = tableView.numberOfSections
    XCTAssertEqual(numberOfSections, 2)
  }
  
  func test_NumberOfRows_Section1_IsToDoCount() {
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
    
    sut.itemManager?.add(ToDoItem(title: "Bar"))
    
    tableView.reloadData()
    
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
  }
  
  func test_NumberOfRows_Section2_IsToDoneCount() {
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    sut.itemManager?.add(ToDoItem(title: "Bar"))
    sut.itemManager?.checkItem(at: 0)
    
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    
    sut.itemManager?.checkItem(at: 0)
    tableView.reloadData()
    
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
  }
  
  func test_CellForRow_ReturnsItemCell() {
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    tableView.reloadData()
    
    let cell =
      tableView.cellForRow(at: IndexPath(row: 0,
                                         section: 0))
    
    XCTAssertTrue(cell is ItemCell)
  }
  
  func test_CellForRow_DequeuesCellFromTableView() {
    let mockTableView = MockTableView.mockTableView(withDataSource: sut)
    
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    mockTableView.reloadData()
    
    _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
    
    XCTAssertTrue(mockTableView.cellGotDequeued)
  }
  
  func test_CellForRow_CallsConfigCell() {
    let mockTableView = MockTableView.mockTableView(withDataSource: sut)
    
    let item = ToDoItem(title: "Foo")
    sut.itemManager?.add(item)
    mockTableView.reloadData()
    
    let cell = mockTableView
      .cellForRow(
        at: IndexPath(row: 0, section: 0))
      as! MockItemCell
    
    XCTAssertEqual(cell.catchedItem, item)
  }

  func test_CellForRow_Section2_CallsConfigCellWithDoneItem() {
    
    let mockTableView = MockTableView.mockTableView(withDataSource: sut)
    
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    
    let second = ToDoItem(title: "Bar")
    sut.itemManager?.add(second)
    sut.itemManager?.checkItem(at: 1)
    mockTableView.reloadData()
    
    let cell = mockTableView
      .cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
    
    
    XCTAssertEqual(cell.catchedItem, second)
  }
  
  func test_DeleteButton_InFirstSection_ShowsTitleCheck() {
    let deleteButtonTitle = tableView.delegate?.tableView?(
      tableView,
      titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0,
                                                          section: 0))
    
    
    XCTAssertEqual(deleteButtonTitle, "Check")
  }
  
  func test_DeleteButton_InSecondSection_ShowsTitleUncheck() {
    let deleteButtonTitle = tableView.delegate?.tableView?(
      tableView,
      titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0,
                                                          section: 1))
    
    XCTAssertEqual(deleteButtonTitle, "Uncheck")
  }
  
  func test_CheckingAnItem_ChecksItInTheItemManager() {
    sut.itemManager?.add(ToDoItem(title: "Foo"))
    
    
    tableView.dataSource?.tableView?(tableView,
                                     commit: .delete,
                                     forRowAt: IndexPath(row: 0,
                                                         section: 0))
    
    
    XCTAssertEqual(sut.itemManager?.toDoCount, 0)
    XCTAssertEqual(sut.itemManager?.doneCount, 1)
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
  }
  
  func test_UncheckingAnItem_UnchecksItInTheItemManager() {
    
    
    sut.itemManager?.add(ToDoItem(title: "First"))
    sut.itemManager?.checkItem(at: 0)
    tableView.reloadData()
    tableView.dataSource?.tableView?(tableView,
                                     commit: .delete,
                                     forRowAt: IndexPath(row: 0,
                                                         section: 1))
    
    
    XCTAssertEqual(sut.itemManager?.toDoCount, 1)
    XCTAssertEqual(sut.itemManager?.doneCount, 0)
    XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
    XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
  } 
}


extension ItemListDataProviderTests {
  
  class MockTableView: UITableView {
    var cellGotDequeued = false
    
    class func mockTableView(
      withDataSource dataSource: UITableViewDataSource)
      -> MockTableView {
        
        let mockTableView = MockTableView(
          frame: CGRect(x: 0, y: 0, width: 320, height: 480),
          style: .plain)
        
        mockTableView.dataSource = dataSource
        mockTableView.register(MockItemCell.self,
                               forCellReuseIdentifier: "ItemCell")
        
        return mockTableView
    }
    
    override func dequeueReusableCell(
      withIdentifier identifier: String,
      for indexPath: IndexPath) -> UITableViewCell {
      
      cellGotDequeued = true
      
      return super.dequeueReusableCell(withIdentifier: identifier,
                                       for: indexPath)
    }
  }
  
  class MockItemCell : ItemCell {
    var catchedItem: ToDoItem?
    
    
    override func configCell(with item: ToDoItem, checked: Bool = false) {
      catchedItem = item
    }
  }
}
