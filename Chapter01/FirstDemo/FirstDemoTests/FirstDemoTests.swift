//
//  FirstDemoTests.swift
//  FirstDemoTests
//
//  Created by dasdom on 10.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import XCTest
@testable import FirstDemo

class FirstDemoTests: XCTestCase {
  
  var viewController: ViewController!
  
  override func setUp() {
    super.setUp()
    viewController = ViewController()
  }
  
  override func tearDown() {
    viewController = nil
    
    super.tearDown()
  }
  
  func test_NumberOfVowels_WhenPassedDominik_ReturnsThree() {
    
    let string = "Dominik"
    
    let numberOfVowels = viewController.numberOfVowels(in: string)
    
    XCTAssertEqual(numberOfVowels, 3,
                   "should find 3 vowels in Dominik")
  }
  
  func test_MakeHeadline_ReturnsStringWithEachWordStartCapital() {
    let input           = "this is A test headline"
    let expectedOutput  = "This Is A Test Headline"
    
    
    let headline = viewController.makeHeadline(from: input)
    
    
    XCTAssertEqual(headline, expectedOutput)
  }
  
  func test_MakeHeadline_ReturnsStringWithEachWordStartCapital2() {
    let input           = "Here is another Example"
    let expectedOutput  = "Here iS Another Example"
    
    
    let headline = viewController.makeHeadline(from: input)
    
    
    XCTAssertEqual(headline, expectedOutput)
  }
}
