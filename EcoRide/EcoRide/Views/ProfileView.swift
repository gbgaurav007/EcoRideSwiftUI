//
//  ProfileView.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 14/11/24.
//

import SwiftUI

struct ProfileView: View {
    @Binding var userData: UserData?
    @Binding var isLoggedIn: Bool
    @State private var showLogoutAlert = false
    @State private var showingImagePicker = false
    @State private var profileImage: UIImage? = nil
    @State private var isLoading = false
    
    var body: some View {
        ScrollView{
            VStack(spacing: 12) {
                Section(header: Text("Profile").font(.headline)){
                    VStack {
                        if let image = profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.bottom)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top)
            
            if let user = userData?.user {
                VStack(alignment: .leading, spacing: 3) {
                    ContactCardDetails(title: "Name", desc: user.name)
                    ContactCardDetails(title: "Email", desc: user.email)
                    ContactCardDetails(title: "Contact", desc: user.contact)
                }
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .padding(.horizontal)
            } else {
                VStack {
                    Image(systemName: "person.crop.circle.fill.badge.xmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .opacity(0.5)
                    Text("No profile data available")
                        .font(.title2)
                        .fontWeight(.bold)
                        .opacity(0.5)
                }
            }
            CustomButton(action: {
                showLogoutAlert = true
            }, label: "Logout")
            .padding(.horizontal)
            .alert(isPresented: $showLogoutAlert) {
                Alert(
                    title: Text("Logout"),
                    message: Text("Are you sure you want to log out?"),
                    primaryButton: .destructive(Text("Logout")) {
                        isLoading = true
                        ProfileViewModel().logout { success in
                            if success {
                                DispatchQueue.main.async {
                                    userData = nil
                                    isLoggedIn = false
                                }
                            }
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .green))
                    .padding(.top)
            }
            
        }
    }
    
}

