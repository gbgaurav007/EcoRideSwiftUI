//
//  RideRowView.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 19/11/24.
//

import SwiftUI

// Row view to display brief ride info
struct RidesRowView: View {
    var ride: Ride
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                // Driver photo placeholder
                AsyncImage(url: URL(string: ride.driverPhotoURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 50)
                }
                
                VStack(alignment: .leading) {
                    Text(ride.driverName)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Car: \(ride.driverCarName)")
                        .foregroundColor(.gray)
                    Text("\(ride.driverCarNumber)")
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("From: \(ride.leavingFrom)")
                    Text("To: \(ride.goingTo)")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Time: \(ride.time)")
                }
            }
            
            HStack {
                Text("Seats Available: \(ride.NumberOfpassengers)")
                Spacer()
                Text("Rs.\(ride.price, specifier: "%.0f")")
            }
            .padding(.top, 8)
        }
        .padding()
    }
}
