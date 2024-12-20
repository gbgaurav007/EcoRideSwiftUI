//
//  AuthResponse.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 27/10/24.
//

import Foundation

struct LoginResponse: Codable {
    var statusCode: Int
    var message: String
    var data: UserData
}

struct SignupResponse: Codable {
    var statusCode: Int
    var message: String
}

struct UserData: Codable {
    var user: User
}
