//
//  RideDetails.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 03/11/24.
//

import Foundation

struct RideDetails: Codable {
    var leavingFrom: String
    var goingTo: String
    var date: String
    var time: String
    var NumberOfpassengers: Int
    var price: String
    var driverCarName: String
    var driverCarNumber: String
}
