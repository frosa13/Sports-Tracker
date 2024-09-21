//
//  Data+Extension.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 21/09/2024.
//

import Foundation

extension Data {
    
    func printAsJSON() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("JSON decode error")
        }
    }
}
