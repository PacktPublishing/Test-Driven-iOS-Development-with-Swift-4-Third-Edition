//
//  APIClient.swift
//  ToDo
//
//  Created by dasdom on 09.09.17.
//  Copyright © 2017 dasdom. All rights reserved.
//

import Foundation

class APIClient {
  
  lazy var session: SessionProtocol = URLSession.shared
  
  func loginUser(withName username: String,
                 password: String,
                 completion: @escaping (Token?, Error?) -> Void) {
    
    let query = "username=\(username.percentEncoded)&password=\(password.percentEncoded)"
    guard let url = URL(string:
      "https://awesometodos.com/login?\(query)") else {
        fatalError()
    }
    
    
    session.dataTask(with: url) { (data, response, error) in
     
      guard error == nil else { return completion(nil, error) }
      
      guard let data = data else {
        completion(nil, WebserviceError.DataEmptyError)
        return
      } 
      
      do {
        let dict = try JSONSerialization.jsonObject(
          with: data,
          options: []) as? [String:String]
        
        
        let token: Token?
        if let tokenString = dict?["token"] {
          token = Token(id: tokenString)
        } else {
          token = nil
        }
        completion(token, nil)
      } catch {
        completion(nil, error)
      }
      }.resume()
  }
}

extension String {
 
  var percentEncoded: String {
    
    let allowedCharacters = CharacterSet(
      charactersIn:
      "/%&=?$#+-~@<>|\\*,.()[]{}^!").inverted
    
    guard let encoded = self.addingPercentEncoding(
      withAllowedCharacters: allowedCharacters) else { fatalError() }
    
    return encoded
  }
}

protocol SessionProtocol {
  func dataTask(
    with url: URL,
    completionHandler: @escaping
    (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionDataTask
}

extension URLSession: SessionProtocol {}

enum WebserviceError : Error {
  case DataEmptyError, ResponseError
}
