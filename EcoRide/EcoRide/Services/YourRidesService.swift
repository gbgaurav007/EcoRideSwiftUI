//
//  YourRidesService.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 19/11/24.
//

import Foundation

// Service to handle API calls related to your rides
class YourRidesService {
    static let shared = YourRidesService()
    
    
    // Fetch saved rides
    func fetchRides(completion: @escaping (Result<[Ride], Error>) -> Void) {
        guard let url = URL(string: "\(API_BASE_URL)/rides/savedRides") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(getAccessToken())", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 404, userInfo: nil)))
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(RidesResponse.self, from: data)
                completion(.success(decodedResponse.data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
