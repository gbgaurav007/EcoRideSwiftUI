//
//  YourRidesView.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 19/11/24.
//

import SwiftUI

// Main view that shows the list of rides
struct YourRidesView: View {
    @ObservedObject var viewModel = YourRidesViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading your rides...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            } else if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else if viewModel.rides.isEmpty {
                Text("You have no booked rides.")
                    .font(.title2)
                    .padding()
            } else {
                ScrollView {
                    VStack(spacing: 16) { // Adds space between ride cards
                        ForEach(viewModel.rides) { ride in
                            RidesRowView(ride: ride)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
                                )
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top, 10) // Adds spacing at the top
                }
            }
        }
        .onAppear {
            viewModel.fetchRides()
        }
        .navigationTitle("Your Rides")
    }
}
