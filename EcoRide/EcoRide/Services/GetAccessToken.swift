//
//  GetAccessToken.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 27/10/24.
//

import Foundation

func getAccessToken() -> String {
    if let cookies = HTTPCookieStorage.shared.cookies {
        for cookie in cookies {
            if cookie.name == "accessToken" {
//                print(cookie.value)
                return cookie.value
            }
        }
    }
    return ""
}
