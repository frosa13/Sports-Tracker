//
//  Event.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 21/09/2024.
//

import Foundation

import Foundation

struct Event: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "i"
        case sportID = "si"
        case name = "d"
        case startTime = "tt"
    }
    
    var id: String
    var sportID: String
    var name: String
    var startTime: Int
}
