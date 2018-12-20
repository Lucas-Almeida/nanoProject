//
//  NetworkHelper.swift
//  Lab
//
//  Created by Roberto Evangelista on 16/12/18.
//  Copyright © 2018 Roberto Evangelista da Silva Filho. All rights reserved.
//

import Foundation

struct NetworkHelper {
    
    let apiURL = "https://api.themoviedb.org/3"
    let apiKey = "0424fa87b82e17923e0bf89b143c6fb2"
    let searchPeopleRequest: String = "/search/person"
    
    func queryItems(dictionary: [String: String]) -> [URLQueryItem] {
        return dictionary.map {
            return URLQueryItem(name: $0, value: $1)
        }
    }
}
