//
//  Constants.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 21/09/2024.
//

import UIKit

enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    case patch
}

enum NetworkError: Error {
    case invalidURL
    case encodingError
    case emptyResponse
    case decodingError
    case serverError(Int)
    case unknown
}

