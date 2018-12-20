//
//  Movie.swift
//  Lab
//
//  Created by Ana Caroline Freitas Sampaio on 17/12/2018.
//  Copyright © 2018 Roberto Evangelista da Silva Filho. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    var title: String?
    var duration: Int?
    var poster: String?
    var releaseDate: String?
    var genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case duration = "runtime"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case genres
    }
    
    mutating func buildMovie(for decode: Movie) {
        self.duration = decode.duration
        self.genres = decode.genres
        self.poster = decode.poster
        self.releaseDate = decode.releaseDate
        self.title = decode.title
    }
}
