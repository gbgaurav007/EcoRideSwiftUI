//
//  BookRideService.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 20/11/24.
//

import Foundation

class BookRideService {
    static let shared = BookRideService()
    
    // Book a ride
    func bookRide(rideId: String, completion: @escaping (Result<Ride, Error>) -> Void) {
        guard let url = URL(string: "\(API_BASE_URL)/rides/bookRide") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(getAccessToken())", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["rideId": rideId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            if let responseString = String(data: data, encoding: .utf8) {
                         print("Response Data: \(responseString)")
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(ApiResponse<Ride>.self, from: data)
                print("Decoded ApiResponse: \(apiResponse)")
                if let ride = apiResponse.data as? Ride {
                    completion(.success(ride))
                    print("Ride Details: \(ride)")
                } else {
                    print("Invalid response: No ride data")
                    completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                }
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}


// Define the structure of the API response
struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let data: T?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
        case message
    }
}
