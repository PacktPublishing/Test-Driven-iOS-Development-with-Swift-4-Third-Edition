//
//  Location.swift
//  ToDo
//
//  Created by dasdom on 12.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Equatable {
  let name: String
  let coordinate: CLLocationCoordinate2D?
  
  init(name: String,
       coordinate: CLLocationCoordinate2D? = nil) {
    
    self.name = name
    self.coordinate = coordinate
  }
  
  public static func ==(lhs: Location,
                        rhs: Location) -> Bool {
    
    if lhs.coordinate?.latitude !=
      rhs.coordinate?.latitude {
      
      return false
    }
    
    if lhs.coordinate?.longitude !=
      rhs.coordinate?.longitude {
      
      
      return false
    }
    
    if lhs.name != rhs.name {
      return false
    }
    
    return true
  }
}
