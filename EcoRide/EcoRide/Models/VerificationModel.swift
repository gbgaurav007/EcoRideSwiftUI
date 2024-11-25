//
//  VerificationModel.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 27/10/24.
//

import Foundation

struct VerificationModel: Codable {
    var carName: String
    var carNumber: String
    var livePhoto: Data?
    
    
    static func validateCarNumber(_ carNumber: String) -> Bool {
        let regex = "^[A-Z]{2} \\d{2} [A-Z]{2} \\d{4}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: carNumber)
    }
}

