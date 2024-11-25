//
//  EcoRideApp.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 27/10/24.
//

import SwiftUI

@main
struct EcoRideApp: App {
    @State private var isLoggedIn = false
    @State private var userData: UserData?
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView(isLoggedIn: $isLoggedIn, userData: $userData)
            } else {
                AccountView(isLoggedIn: $isLoggedIn, updateUserData: { userData in
                    self.userData = userData
                })
            }
        }
        
    }
}
