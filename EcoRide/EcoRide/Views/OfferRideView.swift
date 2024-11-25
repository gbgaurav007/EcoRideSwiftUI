//
//  OfferRideView.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 03/11/24.
//

import SwiftUI

struct OfferRideView: View {
    @StateObject private var viewModel = OfferRideViewModel()
    @Binding var userData: UserData?
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        VStack{
            Text("Offer a Ride")
                .font(.headline)
                .padding(.bottom, 20)
            ScrollView {
                VStack(spacing: 14) {
                    LocationInputField(
                        text: $viewModel.leavingFrom,
                        placeholder: "Leaving from",
                        icon: "mappin.and.ellipse",
                        suggestions: viewModel.filteredLeavingFrom,
                        onTextChange: { _ in viewModel.filterLeavingFromSuggestions() },
                        onSelectSuggestion: { selectedPlace in
                            viewModel.leavingFrom = selectedPlace
                            viewModel.showLeavingFromSuggestions = false
                        }
                    )
                    
                    LocationInputField(
                        text: $viewModel.goingTo,
                        placeholder: "Going to",
                        icon: "location",
                        suggestions: viewModel.filteredGoingTo,
                        onTextChange: { _ in viewModel.filterGoingToSuggestions() },
                        onSelectSuggestion: { selectedPlace in
                            viewModel.goingTo = selectedPlace
                            viewModel.showGoingToSuggestions = false
                        }
                    )
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(Color(.systemGreen))
                        Spacer()
                        DatePicker("", selection: $viewModel.date, displayedComponents: .date)
                            .labelsHidden()
                    }
                    Divider()
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(Color(.systemGreen))
                        Spacer()
                        DatePicker("", selection: $viewModel.time, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    Divider()
                    // Passenger Stepper
                    HStack {
                        Image(systemName: "person.2")
                            .foregroundColor(Color(.systemGreen))
                        Text("\(viewModel.passengers) passenger\(viewModel.passengers > 1 ? "s" : "")")
                        Spacer()
                        Stepper("", value: $viewModel.passengers, in: 1...4)
                            .labelsHidden()
                    }
                    Divider()
                    // Recommended Price Field
                    HStack {
                        Image(systemName: "tag")
                            .foregroundColor(Color(.systemGreen))
                        TextField("Recommended Price (Rs.)", text: $viewModel.price)
                            .keyboardType(.numberPad)
                    }
                    
                    // Publish Ride Button
                    Button(action: {
                        viewModel.publishRide(with: userData!)
                    }) {
                        Text("Publish Ride")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 16)
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text("Message"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                    }
                    
                    Spacer()
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
