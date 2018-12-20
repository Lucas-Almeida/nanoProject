//
//  MovieSearchResponse.swift
//  Lab
//
//  Created by Ana Caroline Freitas Sampaio on 17/12/2018.
//  Copyright © 2018 Roberto Evangelista da Silva Filho. All rights reserved.
//

import Foundation
struct MovieSearchResponse: Decodable {
    var cast: [Movie]?
}
