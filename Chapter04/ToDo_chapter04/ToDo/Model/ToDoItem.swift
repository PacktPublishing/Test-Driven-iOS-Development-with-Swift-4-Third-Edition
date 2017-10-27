//
//  ToDoItem.swift
//  ToDo
//
//  Created by dasdom on 12.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import Foundation

struct ToDoItem: Equatable {
  let title: String
  let itemDescription: String?
  let timestamp: Double?
  let location: Location?
  
  init(title: String,
       itemDescription: String? = nil,
       timestamp: Double? = nil,
       location: Location? = nil) {
    
    self.title = title
    self.itemDescription = itemDescription
    self.timestamp = timestamp
    self.location = location
  }
  
  public static func ==(lhs: ToDoItem,
                        rhs: ToDoItem) -> Bool {
    
    
    if lhs.location != rhs.location {
      return false
    }
    
    if lhs.timestamp != rhs.timestamp {
      return false
    }
    
    if lhs.itemDescription != rhs.itemDescription {
      return false
    }
    
    if lhs.title != rhs.title { 
      return false 
    } 
    
    return true
  }
  
}

