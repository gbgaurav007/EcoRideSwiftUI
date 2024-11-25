//
//  RideDetailView.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 19/11/24.
//

import SwiftUI

// Detailed view of each ride
struct RideDetailView: View {
    var ride: Ride

    var body: some View {
        VStack(spacing: 16) {
            Text("Car: \(ride.driverCarName)")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Car Number: \(ride.driverCarNumber)")
                .font(.subheadline)
            
            Text("Date: \(ride.date)")
                .font(.subheadline)
            
            Text("Time: \(ride.time)")
                .font(.subheadline)
            
            Text("Number of Passengers: \(ride.NumberOfpassengers)")
                .font(.subheadline)
            
            Text("Price: \(String(format: "$%.2f", ride.price))")
                .font(.subheadline)
                .foregroundColor(.green)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Ride Details")
    }
}
