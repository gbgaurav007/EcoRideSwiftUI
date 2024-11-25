//
//  SearchService.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 05/11/24.
//
import Foundation
import Combine

class SearchService {
    func searchRides(rideDetails: RideDetails) -> AnyPublisher<[Ride], Error> {
        guard let url = URL(string: "\(API_BASE_URL)/rides/searchRides") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(getAccessToken())", forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "NumberOfpassengers": rideDetails.NumberOfpassengers,
            "leavingFrom": rideDetails.leavingFrom,
            "goingTo": rideDetails.goingTo,
            "date": rideDetails.date
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: RidesResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
