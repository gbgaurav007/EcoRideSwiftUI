//
//  YourRidesViewModel.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 19/11/24.
//

import Foundation

// ViewModel to handle fetching your rides
class YourRidesViewModel: ObservableObject {
    @Published var rides: [Ride] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil

    // Fetch rides using the service
    func fetchRides() {
        YourRidesService.shared.fetchRides { result in
            switch result {
            case .success(let rides):
                DispatchQueue.main.async {
                    self.rides = rides
                    self.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
