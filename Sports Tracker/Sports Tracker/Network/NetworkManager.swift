//
//  NetworkManager.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 21/09/2024.
//

import Foundation

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    private var session = URLSession(configuration: .default)
    
    deinit {
        self.session.finishTasksAndInvalidate()
    }
    
    func sendRequest<D: Decodable>(endpoint: Endpoint, decodeTo: D.Type, completion: @escaping (D?, Error?) -> Void) {

        guard let request = createRequest(with: endpoint.url, type: endpoint.method) else {
            completion(nil, NetworkError.invalidURL)
            return
        }
        
        let taskCompletion: (Data?, URLResponse?, Error?) -> Void = { data, response, error in
            
            guard let data else {
                completion(nil, NetworkError.emptyResponse)
                return
            }
            
            if let error {
                print("Response: \(error.localizedDescription)")
                print("Response: \(endpoint.url?.absoluteString ?? "") failed with: \(error)")
                completion(nil, error)
            }
            
            print("Response: \(response.debugDescription)")
            data.printAsJSON()
            
            guard let result = try? JSONDecoder().decode(D.self, from: data) else {
                completion(nil, NetworkError.decodingError)
                return
            }

            completion(result, nil)
        }
        
        let task = self.session.customDataTask(with: request) { data, response, error in
            taskCompletion(data, response, error)
        }
        task.resume()
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod = .get) -> URLRequest? {
        
        guard let url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        return request
    }
}

extension URLSession {
    func customDataTask(
        with request: URLRequest,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void
    ) -> URLSessionDataTask {
        
        return dataTask(with: request, completionHandler: completionHandler)
    }
}
