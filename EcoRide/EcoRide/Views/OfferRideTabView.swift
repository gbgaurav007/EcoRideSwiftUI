//
//  OfferRideTabView.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 16/11/24.
//

import Foundation
import SwiftUI

struct OfferRideTabView: View {
    @Binding var userData: UserData?
    @State private var isDriverVerified: Bool = false // State for verification
    
    var body: some View {
        Group {
            if isDriverVerified {
                OfferRideView(userData: $userData)
            } else {
                VerificationView(isDriverVerified: $isDriverVerified)
            }
        }
        .onAppear {
            // Check driver verification state from userData
            if let verification = userData?.user.driverVerification {
                isDriverVerified = verification.carName != nil &&
                                   verification.carNumber != nil &&
                                   verification.livePhoto != nil
            }
            print("OfferRideTabView appeared. Checking verification state.")
        }
        .onChange(of: isDriverVerified) { newValue in
                    if newValue {
                        // Handle any additional logic if needed when verification is successful
                        print("Driver verified. Transitioning to OfferRideView.")
                    }
                }
    }
}
