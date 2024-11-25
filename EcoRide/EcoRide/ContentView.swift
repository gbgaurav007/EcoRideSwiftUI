//
//  ContentView.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 27/10/24.
//

import SwiftUI

struct ContentView: View {
    @Binding var isLoggedIn : Bool
    @Binding var userData: UserData?
    
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            // Publish Ride Tab
            OfferRideTabView(userData: $userData)
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Publish Ride")
                }
            
            // Your Rides Tab
            YourRidesView()
                .tabItem {
                    Image(systemName: "car.fill")
                    Text("Your Rides")
                }
            
            // Profile Tab
            ProfileView(userData: $userData, isLoggedIn: $isLoggedIn)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}


struct PublishRideView: View {
    var body: some View {
        Text("Publish Ride View")
    }
}
