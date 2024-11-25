//
//  CustomAlert.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 14/11/24.
//

import SwiftUI

func customAlert(
    title: String,
    message: String,
    primaryAction: @escaping () -> Void,
    secondaryAction: @escaping () -> Void
) -> Alert {
    return Alert(
        title: Text(title),
        message: Text(message),
        primaryButton: .destructive(Text("Logout"), action: primaryAction),
        secondaryButton: .cancel(secondaryAction)
    )
}
