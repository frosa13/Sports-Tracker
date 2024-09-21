//
//  SportsAPI.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 21/09/2024.
//

import Foundation

struct SportsAPI {
    
    func getSports(completion: @escaping (_ success: Bool, _ error: Error?, _ sports: [Sport]?) -> Void) {
        NetworkManager.shared.sendRequest(
            endpoint: .sports,
            decodeTo: [Sport].self
        ) { sports, error in
            guard error == nil else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, sports)
        }
    }
}
