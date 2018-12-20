//
//  ImagePath.swift
//  Lab
//
//  Created by Ana Caroline Freitas Sampaio on 17/12/2018.
//  Copyright © 2018 Roberto Evangelista da Silva Filho. All rights reserved.
//

import Foundation

struct ImageBuilder {
    enum ProfileImageWidth: String {
        case w45 = "/w45"
        case w185 = "/w185"
        case h632 = "/h632"
        case original = "/original"
    }
    let partialImageURL: String = "https://image.tmdb.org/t/p"
    let profileImagePathWidth: String = ProfileImageWidth.original.rawValue
    var path: String
    var noImageAvailable: String = "no_image_available"
    var noMovieAvailable: String = "no_movie_available"
    
    init() {
        self.path = ""
    }
    
    mutating func isImagePathValid(for imagePath: String?) -> Bool {
        if let unwrappedImagePath = imagePath {
            path = partialImageURL + profileImagePathWidth + unwrappedImagePath
            return true
        } else {
            return false
        }
    }
    
    func getImage(_ urlString: String, completion: @escaping (Data?, Error?) -> (Void)) {
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            let url = URL(string: encoded)
            
            let session = URLSession.shared
            let task = session.dataTask(with: url!) {
                (data, response, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            }
            task.resume()
        }
    }
}
