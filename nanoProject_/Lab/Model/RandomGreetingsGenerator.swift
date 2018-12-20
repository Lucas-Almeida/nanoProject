//
//  RandomGreetingsGenerator.swift
//  Lab
//
//  Created by Ana Freitas Sampaio on 12/17/18.
//  Copyright © 2018 Roberto Evangelista da Silva Filho. All rights reserved.
//

import Foundation

struct GreetingGenerator {
    let greetings: [String] = [
        "Search your favorite actors!",
        "Find here that hot actor",
        "Look up for that actor or actress :)"
    ]
    
    func getRandomGreeting() -> String {
        let randomIndex = Int.random(in: 0..<greetings.count)
        return greetings[randomIndex]
    }
}

