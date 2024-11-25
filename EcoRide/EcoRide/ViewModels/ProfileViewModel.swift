//
//  ProfileViewModel.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 14/11/24.
//


import Foundation

class ProfileViewModel {
    
    func logout(completion: @escaping (Bool) -> Void) {
        LogoutService().performLogout { success in
            completion(success)
        }
    }
}
