//
//  Actor.swift
//  Lab
//
//  Created by Roberto Evangelista da Silva Filho on 14/12/2018.
//  Copyright © 2018 Roberto Evangelista da Silva Filho. All rights reserved.
//

import Foundation
struct Actor: Decodable {
    let id: Int
    let name: String?
    let birthday: String?
    let birthplace: String?
    let biography: String?
    let picture: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case birthday
        case birthplace = "place_of_birth"
        case biography
        case picture = "profile_path"
    }
}
