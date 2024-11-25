//
//  Ride.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 15/11/24.
//
import Foundation


struct Ride: Identifiable, Codable {
    let id: String
    let time: String
    let date: String
    let price: Double
    let NumberOfpassengers: Int
    let leavingFrom: String
    let goingTo: String
    let driverPhotoURL: String
    let driverName: String
    let driverContact: Int
    let driverCarName: String
    let driverCarNumber: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case driverPhotoURL = "driverPhoto"
        case time,date,price, NumberOfpassengers, leavingFrom, goingTo, driverName, driverContact, driverCarName, driverCarNumber
    }
}

struct RidesResponse: Decodable {
    let statusCode: Int
    let message: String
    let data: [Ride]
}
