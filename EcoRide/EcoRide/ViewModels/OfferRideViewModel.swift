//
//  OfferRideViewModel.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 03/11/24.
//

import SwiftUI
import Combine

class OfferRideViewModel: ObservableObject {
    // Ride Information
    @Published var leavingFrom: String = ""
    @Published var goingTo: String = ""
    @Published var date: Date = Date()
    @Published var time: Date = Date()
    @Published var passengers: Int = 1
    @Published var price: String = ""
    @Published var alertMessage: String = ""
    @Published var showAlert = false
    
    // Search Suggestions
    @Published var showLeavingFromSuggestions = false
    @Published var showGoingToSuggestions = false
    @Published var filteredLeavingFrom: [String] = []
    @Published var filteredGoingTo: [String] = []
    
    let places = ["Elante Mall", "Sector 17", "Rock Garden", "Tribune Chowk", "ISBT 43", "PEC", "Sukhna Lake", "Palika Bazaar", "Shastri Market", "PU", "GMCH 32", "I.S Bindra Stadium", "Airport, Mohali", "Railway Station", "Chhatbir Zoo", "Mansa Devi Temple", "Town Park, Panchkula", "Pinjore Garden", "Best Price, Zirakpur", "Haldirams, Derabassi"]
    
    private let rideService = RideService()
    func filterLeavingFromSuggestions() {
          filteredLeavingFrom = places.filter { $0.lowercased().hasPrefix(leavingFrom.lowercased()) }
          showLeavingFromSuggestions = !filteredLeavingFrom.isEmpty
      }
      
      // Function to select "Leaving From" suggestion
      func selectLeavingFrom(_ place: String) {
          leavingFrom = place
          showLeavingFromSuggestions = false
      }
      
      // Function to filter "Going To" suggestions
      func filterGoingToSuggestions() {
          filteredGoingTo = places.filter { $0.lowercased().hasPrefix(goingTo.lowercased()) }
          showGoingToSuggestions = !filteredGoingTo.isEmpty
      }
      
      // Function to select "Going To" suggestion
      func selectGoingTo(_ place: String) {
          goingTo = place
          showGoingToSuggestions = false
      }
      
      // Function to set default time to current
      func setDefaultTime() {
          let calendar = Calendar.current
          let hour = calendar.component(.hour, from: Date())
          let minute = calendar.component(.minute, from: Date())
          self.time = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
      }
      
    
    func publishRide(with userData: UserData) {
           guard let driverVerification = userData.user.driverVerification,
                 let driverCarName = driverVerification.carName,
                 let driverCarNumber = driverVerification.carNumber else {
               self.alertMessage = "Driver details are incomplete. Please verify your profile."
               self.showAlert = true
               return
           }
           
           let rideDetails = RideDetails(
               leavingFrom: leavingFrom,
               goingTo: goingTo,
               date: formatDate(date: date),
               time: formatTime(date: time),
               NumberOfpassengers: passengers,
               price: price,
               driverCarName: driverCarName,
               driverCarNumber: driverCarNumber
           )
           
        
        rideService.publishRide(rideDetails) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.alertMessage = response.message
                case .failure(let error):
                    self.alertMessage = "Error: \(error.localizedDescription)"
                }
                self.showAlert = true
            }
        }
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    private func formatTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
