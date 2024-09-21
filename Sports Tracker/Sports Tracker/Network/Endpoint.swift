//
//  Endpoint.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 21/09/2024.
//

import Foundation

enum Endpoint: String {
    case sports = "https://0083c2a8-dfe1-4a25-a7f7-8cc32f1de2c3.mock.pstmn.io/api/sports"
    
    var url: URL? {
        return URL(string: self.rawValue)
    }
    
    var method: HTTPMethod {
        switch self {
        case .sports:
            return .get
        }
    }
}
