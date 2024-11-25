//
//  SearchViewModel.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 05/11/24.
//
import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var rides: [Ride] = []
    @Published var originalRides: [Ride] = []
    @Published var searchPerformed: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let searchService = SearchService()
    
    @Published var showLeavingFromSuggestions = false
    @Published var showGoingToSuggestions = false
    @Published var filteredLeavingFrom: [String] = []
    @Published var filteredGoingTo: [String] = []
    
    let places = ["Elante Mall", "Sector 17", "Rock Garden", "Tribune Chowk", "ISBT 43", "PEC", "Sukhna Lake", "Palika Bazaar", "Shastri Market", "PU", "GMCH 32", "I.S Bindra Stadium", "Airport, Mohali", "Railway Station", "Chhatbir Zoo", "Mansa Devi Temple", "Town Park, Panchkula", "Pinjore Garden", "Best Price, Zirakpur", "Haldirams, Derabassi"]
    
    private let rideService = RideService()
    func updateLeavingFrom(_ input: String) {
           filteredLeavingFrom = places.filter { $0.lowercased().contains(input.lowercased()) }
           showLeavingFromSuggestions = !filteredLeavingFrom.isEmpty
       }

       func updateGoingTo(_ input: String) {
           filteredGoingTo = places.filter { $0.lowercased().contains(input.lowercased()) }
           showGoingToSuggestions = !filteredGoingTo.isEmpty
       }

       func selectLeavingFrom(_ place: String) {
           showLeavingFromSuggestions = false
       }

       func selectGoingTo(_ place: String) {
           showGoingToSuggestions = false
       }
      
    
    func searchRides(rideDetails: RideDetails) {
        searchService.searchRides(rideDetails: rideDetails)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] rides in
                self?.rides = rides
                self?.originalRides = rides
                self?.searchPerformed = true
            })
            .store(in: &cancellables)
    }
}
