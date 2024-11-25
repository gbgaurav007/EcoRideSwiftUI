//
//  User.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 27/10/24.
//

import Foundation

struct User: Codable {
    var email: String
    var name: String
    var contact: String
    var isDriver: Bool
    var driverVerification: DriverVerification?
}

struct DriverVerification: Codable {
    var carName: String?
    var carNumber: String?
    var livePhoto: String?
}
