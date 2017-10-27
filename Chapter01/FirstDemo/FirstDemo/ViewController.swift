//
//  ViewController.swift
//  FirstDemo
//
//  Created by dasdom on 10.08.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func numberOfVowels(in string: String) -> Int {
    let vowels: [Character] = ["a", "e", "i", "o", "u",
                               "A", "E", "I", "O", "U"]
    
    return string.characters.reduce(0) {
      $0 + (vowels.contains($1) ? 1 : 0)
    }
  }
  
  func makeHeadline(from string: String) -> String {
    let words = string.components(separatedBy: " ")
    
    
    let headlineWords = words.map { (word) -> String in
      var mutableWord = word
      let first = mutableWord.remove(at: mutableWord.startIndex)
      
      return String(first).uppercased() + mutableWord
    }
    
    
    return headlineWords.joined(separator: " ")
  }
}

