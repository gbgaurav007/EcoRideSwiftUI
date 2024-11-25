//
//  RideListView.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 05/11/24.
//


import SwiftUI

struct RidesListView: View {
    let rides: [Ride]
    
    var body: some View {
        VStack {
            if rides.isEmpty {
                Text("No rides found!")
                    .font(.headline)
                    .padding()
            } else {
                List(rides) { ride in
                    RideRowView(ride: ride)
                }
            }
        }
        .navigationTitle("Available Rides")
    }
}

struct RideRowView: View {
    @State private var isBooking = false
    @State private var bookingError: String? = nil
    @State private var bookingSuccess = false
    
    let ride: Ride
    
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
            
            Button(action: {
                isBooking = true
                bookingError = nil
                
                // Call the bookRide API
                BookRideService.shared.bookRide(rideId: ride.id) { result in
                    DispatchQueue.main.async {
                        isBooking = false
                        switch result {
                        case .success(let bookedRide):
                            bookingSuccess = true
                        case .failure(let error):
                            bookingError = error.localizedDescription
                        }
                    }
                }
            }) {
                Text(bookingSuccess ? "Booked" : isBooking ? "Booking..." : "Book Ride")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .font(.headline)
            }
            .disabled(bookingSuccess || isBooking)
            .padding(.top, 10)
        }
        .padding()
        .alert(isPresented: Binding<Bool>(get: {
            bookingError != nil
        }, set: { _ in
            bookingError = nil
        })) {
            Alert(
                title: Text("Error"),
                message: Text(bookingError ?? "Unknown error"),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $bookingSuccess) {
            Alert(
                title: Text("Success"),
                message: Text("Ride booked successfully!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
