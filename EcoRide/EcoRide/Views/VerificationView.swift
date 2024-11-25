//
//  VerificationView.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 27/10/24.
//

import SwiftUI
struct VerificationView: View {
    @StateObject private var viewModel = VerificationViewModel()
    @State private var isCameraPresented: Bool = false
    @State private var isPhotoLibraryPresented: Bool = false
    @Binding var isDriverVerified: Bool 
    
    var body: some View {
        VStack {
            Text("Verify Your Profile!")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Form {
                Section(header: Text("Car Information")) {
                    TextField("Car Name", text: $viewModel.carName)
                    TextField("Car Number", text: $viewModel.carNumber)
                        .keyboardType(.default)
                        .onChange(of: viewModel.carNumber) {
                            if !viewModel.validateCarNumber() {
                                viewModel.verificationStatus = "Car number format: XX 00 XX 0000."
                            } else {
                                viewModel.verificationStatus = ""
                            }
                        }
                }
                
                Section(header: Text("Aadhar Card")) {
                    if let aadharImage = viewModel.aadharCard {
                        Image(uiImage: aadharImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                        Button("Retake Aadhar Photo", action: { isPhotoLibraryPresented.toggle() })
                    } else {
                        Button(action: {
                            isPhotoLibraryPresented.toggle()
                        }) {
                            Text("Upload Aadhar Card")
                        }
                    }
                }
                
                Section(header: Text("Live Photo")) {
                    if let photo = viewModel.livePhoto {
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                        Button("Retake Photo", action: { isCameraPresented.toggle() })
                    } else {
                        Button("Take Live Photo", action: { isCameraPresented.toggle() })
                    }
                }
                
                Button("Verify Profile", action: {
                    viewModel.verifyProfile()
                })
                .disabled(!viewModel.isFormComplete())
            }
            .alert(isPresented: .constant(!viewModel.verificationStatus.isEmpty)) {
                Alert(title: Text("Verification Status"), message: Text(viewModel.verificationStatus), dismissButton: .default(Text("OK")))
            }
        }
        .onAppear {
            viewModel.onVerificationSuccess = {
                isDriverVerified = true
            }
        }
        .sheet(isPresented: $isCameraPresented) {
            CameraView(capturedPhoto: $viewModel.livePhoto)
        }
        .sheet(isPresented: $isPhotoLibraryPresented) {
            ImagePicker(image: $viewModel.aadharCard)
        }
    }
}
