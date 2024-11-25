//
//  RideResponse.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 03/11/24.
//

import Foundation

struct RideResponse: Codable {
    var statusCode: Int
    var data: RideData
    var message: String
    var success: Bool
}
