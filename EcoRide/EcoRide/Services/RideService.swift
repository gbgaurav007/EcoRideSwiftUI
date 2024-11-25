//
//  RideService.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 03/11/24.
//

import Foundation

struct RideService {
    
    func publishRide(_ rideDetails: RideDetails, completion: @escaping (Result<RideResponse, Error>) -> Void) {
        guard let url = URL(string: "\(API_BASE_URL)/rides/publishRide") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(getAccessToken())", forHTTPHeaderField: "Authorization")
        
        do {
            let requestData = try JSONEncoder().encode(rideDetails)
            request.httpBody = requestData
            if let jsonString = String(data: requestData, encoding: .utf8) {
                           print("Outgoing JSON data: \(jsonString)")
                       }
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {

                completion(.failure(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                           print("HTTP Status Code: \(httpResponse.statusCode)")
                       }
                       
            
            guard let data = data else {

                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                           print("Incoming JSON data: \(jsonString)")
                       }
                       
            
            do {
                let response = try JSONDecoder().decode(RideResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
