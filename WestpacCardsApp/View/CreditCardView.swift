//
//  CreditCardView.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import SwiftUI

struct CreditCardView: View {
    let model: CreditCard
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.type)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Text(model.number)
                .foregroundColor(.primary)
                .lineLimit(1)
            Text(model.expiryDate)
                .foregroundColor(.primary)
                .lineLimit(1)
        }
        .padding()
    }
}
