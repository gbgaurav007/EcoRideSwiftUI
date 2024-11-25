//
//  SearchView.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 05/11/24.
//
import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @StateObject private var savedRideViewModel = YourRidesViewModel()
    @State private var leavingFrom = ""
    @State private var goingTo = ""
    @State private var date = Date()
    @State private var passengers = 1
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Search Ride")
                    .font(.headline)
                    .padding(.bottom,20)
                ScrollView{
                    VStack (spacing: 14) {
                        LocationInputField(
                            text: $leavingFrom,
                            placeholder: "Leaving from",
                            icon: "mappin.and.ellipse",
                            suggestions: viewModel.filteredLeavingFrom,
                            onTextChange: { input in  viewModel.updateLeavingFrom(input) },
                            onSelectSuggestion: { selectedPlace in
                                leavingFrom = selectedPlace
                                viewModel.selectLeavingFrom(selectedPlace)
                            }
                        )
                        LocationInputField(
                            text: $goingTo,
                            placeholder: "Going to",
                            icon: "location",
                            suggestions: viewModel.filteredGoingTo,
                            onTextChange: { input in
                                viewModel.updateGoingTo(input) },
                            onSelectSuggestion: { selectedPlace in
                                goingTo = selectedPlace
                                viewModel.selectGoingTo(selectedPlace)
                            }
                        )
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(Color(.systemGreen))
                            Spacer()
                            DatePicker("", selection: $date, displayedComponents: .date)
                                .labelsHidden()
                        }
                        Divider()
                        HStack {
                            Image(systemName: "person.2")
                                .foregroundColor(Color(.systemGreen))
                            Spacer()
                            Stepper("Passengers: \(passengers)", value: $passengers, in: 1...4)
                        }
                        Divider()
                        NavigationLink(
                            destination: {
                                let _ = searchRides()
                                RidesListView(rides: viewModel.rides)
                            },
                            label: {
                                Text("Search")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(.systemGreen))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        )
                    }
                    .padding(.top, 10)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        keyboardFocused = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
            
        }
    }
    
    private func searchRides() {
        guard !leavingFrom.isEmpty, !goingTo.isEmpty else {
            return
        }
        
        if leavingFrom == goingTo {
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: date)
        
        let rideDetails = RideDetails(
            leavingFrom: leavingFrom,
            goingTo: goingTo,
            date: formattedDate,
            time: "",
            NumberOfpassengers: passengers,
            price: "",
            driverCarName: "",
            driverCarNumber: ""
        )
        
        viewModel.searchRides(rideDetails: rideDetails)
    }
}
