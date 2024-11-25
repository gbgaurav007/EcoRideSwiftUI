//
//  VerificationViewModel.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 27/10/24.
//

import Foundation
import SwiftUI
import Combine
import PhotosUI

class VerificationViewModel: ObservableObject {
    @Published var carName: String = ""
    @Published var carNumber: String = ""
    @Published var aadharCard: UIImage? = nil
    @Published var livePhoto: UIImage? = nil
    @Published var verificationStatus: String = ""
    
    private var verificationService = VerificationService()
    var onVerificationSuccess: (() -> Void)?
    
    func isFormComplete() -> Bool {
        return !carName.isEmpty && !carNumber.isEmpty && aadharCard != nil && livePhoto != nil
    }
    
    func validateCarNumber() -> Bool {
        return VerificationModel.validateCarNumber(carNumber)
    }
    
    func verifyProfile() {
        guard let livePhoto = livePhoto, let livePhotoData = livePhoto.jpegData(compressionQuality: 0.8) else {
            verificationStatus = "Please upload required photos."
            return
        }
        
        let verificationData = VerificationModel(carName: carName, carNumber: carNumber, livePhoto: livePhotoData)
        
        verificationService.verifyDriver(data: verificationData) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.verificationStatus = "Profile verified successfully."
                    self.onVerificationSuccess?() // Notify parent view
                    print("Profile verified successfully.")
                case .failure(let error):
                    self.verificationStatus = "Verification failed: \(error.localizedDescription)"
                }
            }
        }
    }
}
