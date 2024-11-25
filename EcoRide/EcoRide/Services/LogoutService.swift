//
//  LogoutService.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 14/11/24.
//

import Foundation

class LogoutService {
    
    func performLogout(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(API_BASE_URL)/users/logout") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(getAccessToken())", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error logging out:", error?.localizedDescription ?? "")
                completion(false)
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Logout successful")
                
                // Remove accessToken and refreshToken cookies
                if let cookies = HTTPCookieStorage.shared.cookies {
                    for cookie in cookies where cookie.name == "accessToken" || cookie.name == "refreshToken" {
                        HTTPCookieStorage.shared.deleteCookie(cookie)
                    }
                }
                completion(true)
            } else {
                print("Logout failed:", String(data: data, encoding: .utf8) ?? "")
                completion(false)
            }
        }.resume()
    }
}
