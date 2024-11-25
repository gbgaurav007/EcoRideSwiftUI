//
//  RideData.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 03/11/24.
//

import Foundation

struct RideData: Codable {
    var driverName: String
    var driverContact: Int
    var driverCarName: String
    var driverCarNumber: String
    var driverPhoto: String
    var leavingFrom: String
    var goingTo: String
    var date: String
    var time: String
    var NumberOfpassengers: Int
    var price: Int
    var _id: String
    var createdAt: String
    var updatedAt: String
    var __v: Int
}
