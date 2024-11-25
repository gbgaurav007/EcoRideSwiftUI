//
//  AccountViewModel.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 27/10/24.
//


import SwiftUI
import Combine

let API_BASE_URL = "https://ecoride-4atb.onrender.com/api/v1"

class AccountViewModel: ObservableObject {
    @Published var isLogin: Bool = true
    @Published var formData: FormData = FormData()
    @Published var errors: FormErrors = FormErrors()
    @Published var alertMessage: String?
    @Published var isAlertPresented: Bool = false
    @Published var showPassword: Bool = false
    @Binding var isLoggedIn: Bool
    @Published var userData: UserData?
    @Published var isLoading = false
    
    
    var updateUserData: ((UserData) -> Void)?
    
    struct FormData {
        var name: String = ""
        var contact: String = ""
        var email: String = ""
        var password: String = ""
    }
    
    struct FormErrors {
        var email: String = ""
        var contact: String = ""
        var password: String = ""
    }
    
    init(isLoggedIn: Binding<Bool>, updateUserData: ((UserData) -> Void)? = nil) {
           _isLoggedIn = isLoggedIn
           self.updateUserData = updateUserData
       }
    
    func handleLogin() {
        isLoading = true
        
        let url = URL(string: "\(API_BASE_URL)/users/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": formData.email, "password": formData.password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.alertMessage = "Login failed: \(error.localizedDescription)"
                    self.isAlertPresented = true
                }
                return
            }
            
            guard let data = data else { return }
            do {
                let jsonResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                if jsonResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.isLoggedIn = true
                        self.userData = jsonResponse.data
                        self.updateUserData?(jsonResponse.data)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.alertMessage = jsonResponse.message
                        self.isAlertPresented = true
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.alertMessage = "Failed to decode response"
                    self.isAlertPresented = true
                }
            }
        }.resume()
    }
    
    func handleSignup() {
        isLoading = true
        
        let url = URL(string: "\(API_BASE_URL)/users/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["name": formData.name, "contact": formData.contact, "email": formData.email, "password": formData.password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.alertMessage = "Registration failed: \(error.localizedDescription)"
                    self.isAlertPresented = true
                }
                return
            }
            
            guard let data = data else { return }
            do {
                let jsonResponse = try JSONDecoder().decode(SignupResponse.self, from: data)
                if jsonResponse.statusCode == 201 {
                    DispatchQueue.main.async {
                        self.alertMessage = "Signup Successful"
                        self.isAlertPresented = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.alertMessage = jsonResponse.message
                        self.isAlertPresented = true
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.alertMessage = "Failed to decode response"
                    self.isAlertPresented = true
                }
            }
        }.resume()
    }
}
