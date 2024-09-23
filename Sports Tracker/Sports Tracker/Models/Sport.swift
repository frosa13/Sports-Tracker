//
//  Sport.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 21/09/2024.
//

import Foundation

struct Sport: Codable {
    enum SportType: String {
        case football = "FOOT"
        case basketball = "BASK"
        case tennis = "TENN"
        case tabletennis = "TABL"
        case volleyball = "VOLL"
        case esports = "ESPS"
        case icehokey = "ICEH"
        case handball = "HAND"
        case snooker = "SNOO"
        case futsal = "FUTS"
        case darts = "DART"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "i"
        case name = "d"
        case events = "e"
    }
    
    var id: String
    var name: String
    var events: [Event]
}

// MARK: - Helper methods
extension Sport {
    
    var iconName: String {
        guard let sportType = SportType(rawValue: id) else {
            return ImageName.misc
        }
        
        switch sportType {
        case .football:
            return ImageName.football
        case .basketball:
            return ImageName.basketball
        case .tennis:
            return ImageName.tennis
        case .tabletennis:
            return ImageName.tabletennis
        case .volleyball:
            return ImageName.volleyball
        case .esports:
            return ImageName.esports
        case .icehokey:
            return ImageName.icehookey
        case .handball:
            return ImageName.handball
        case .snooker:
            return ImageName.snooker
        case .futsal:
            return ImageName.futsal
        case .darts:
            return ImageName.darts
        }
    }
}
