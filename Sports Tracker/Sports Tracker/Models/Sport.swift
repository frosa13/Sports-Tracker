//
//  Sport.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 21/09/2024.
//

import Foundation

struct Sport: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "i"
        case name = "d"
        case events = "e"
    }
    
    var id: String
    var name: String
    var events: [Event]
}
