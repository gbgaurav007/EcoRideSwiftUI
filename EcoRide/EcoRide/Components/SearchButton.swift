//
//  SearchButton.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 16/11/24.
//

import Foundation
import SwiftUI

struct SearchButton: View {
    let action: () -> Void
    let label: String
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGreen))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        
    }
}
