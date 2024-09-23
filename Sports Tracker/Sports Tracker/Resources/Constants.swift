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

enum Radius: CGFloat {
    case r4 = 4
    case r8 = 8
}

enum Margin: CGFloat {
    case m4 = 4
    case m8 = 8
    case m16 = 16
    case m32 = 32
}

enum Size: CGFloat {
    case s12 = 12
    case s24 = 24
    case s32 = 32
    case s44 = 44
    case s100 = 100
}

enum ViewState: String {
    case success
    case error
    case loading
}
