//
//  SearchBarView.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 05/11/24.
//

import SwiftUI

struct SearchBarView: View {
    var searchAction: (RideDetails) -> Void
    
    @State private var leavingFrom: String = ""
    @State private var goingTo: String = ""
    @State private var date = Date()
    @State private var passengers: Int = 1
    
    @State private var filteredLeavingFrom: [String] = []
    @State private var filteredGoingTo: [String] = []
    @State private var showLeavingFromSuggestions = false
    @State private var showGoingToSuggestions = false
    
    let places = [
        "Elante Mall", "Sector 17", "Rock Garden", "Tribune Chowk", "ISBT 43", "PEC",
        "Sukhna Lake", "Palika Bazaar", "Shastri Market", "PU", "GMCH 32", "I.S Bindra Stadium", "Airport, Mohali",
        "Railway Station", "Chhatbir Zoo", "Mansa Devi Temple", "Town Park, Panchkula", "Pinjore Garden",
        "Best Price, Zirakpur", "Haldirams, Derabassi"
    ]
    
    var today: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "location.fill")
                TextField("Leaving from", text: $leavingFrom, onEditingChanged: { isEditing in
                    showLeavingFromSuggestions = isEditing
                    if isEditing {
                        filteredLeavingFrom = places.filter { $0.lowercased().hasPrefix(leavingFrom.lowercased()) }
                    }
                })
                .onChange(of: leavingFrom) {
                    filteredLeavingFrom = places.filter { $0.lowercased().hasPrefix(leavingFrom.lowercased()) }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
            if showLeavingFromSuggestions {
                List(filteredLeavingFrom, id: \.self) { place in
                    Text(place)
                        .onTapGesture {
                            leavingFrom = place
                            showLeavingFromSuggestions = false
                        }
                }
                .frame(maxHeight: 100)
            }
            
            HStack {
                Image(systemName: "location.fill")
                TextField("Going to", text: $goingTo, onEditingChanged: { isEditing in
                    showGoingToSuggestions = isEditing
                    if isEditing {
                        filteredGoingTo = places.filter { $0.lowercased().hasPrefix(goingTo.lowercased()) }
                    }
                })
                .onChange(of: goingTo) {
                    filteredGoingTo = places.filter { $0.lowercased().hasPrefix(goingTo.lowercased()) }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
            if showGoingToSuggestions {
                List(filteredGoingTo, id: \.self) { place in
                    Text(place)
                        .onTapGesture {
                            goingTo = place
                            showGoingToSuggestions = false
                        }
                }
                .frame(maxHeight: 100)
            }

            // Date Picker
            HStack {
                Image(systemName: "calendar")
                DatePicker("Date", selection: $date, in: today..., displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        
            // Passenger Selector
            HStack {
                Image(systemName: "person.fill")
                Text("\(passengers) \(passengers == 1 ? "passenger" : "passengers")")
                    .padding(.horizontal)
                Spacer()
                Button(action: {
                    if passengers > 1 { passengers -= 1 }
                }) {
                    Image(systemName: "minus.circle")
                        .font(.system(size: 24))
                }
                Button(action: {
                    if passengers < 4 { passengers += 1 }
                }) {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 24))
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
            // Search Button
            Button(action: handleSearch) {
                Text("Search")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.top)
        }
        .padding()
    }
    
    private func handleSearch() {
        guard !leavingFrom.isEmpty, !goingTo.isEmpty else {
            print("Please fill all the fields")
            return
        }
        
        if leavingFrom == goingTo {
            print("Pick-up and Drop destinations cannot be the same.")
            return
        }
        
        let rideDetails = RideDetails(
            leavingFrom: leavingFrom,
            goingTo: goingTo,
            date: formatDate(date: date),
            time: "",
            NumberOfpassengers: passengers,
            price: "",
            driverCarName: "Driver Car Name",
            driverCarNumber: "Driver Car Number"
        )
        searchAction(rideDetails)
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
