//
//  SuggestionListView.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 03/11/24.
//

import SwiftUI

struct SuggestionListView: View {
    var suggestions: [String]
    var onSelect: (String) -> Void

    var body: some View {
        List(suggestions, id: \.self) { suggestion in
            Text(suggestion)
                .onTapGesture {
                    onSelect(suggestion)
                }
        }
        .frame(height: 100)
    }
}
