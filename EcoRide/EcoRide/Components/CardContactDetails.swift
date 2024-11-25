//
//  CardContactDetails.swift
//  EcoRide
//
//  Created by Gaurav Bansal on 19/11/24.
//

import SwiftUI

struct ContactCardDetails: View{
    var title: String
    var desc: String
    var showDivider: Bool = true
    var body: some View{
        HStack{
            Text(title)
                .font(.headline)
            Spacer()
            Text(desc)
                .opacity(0.5)
        }.padding(.vertical, 12)
        if(showDivider){
            Divider()
        }
    }
}
