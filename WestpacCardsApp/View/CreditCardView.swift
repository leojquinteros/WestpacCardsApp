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
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(model.type.description)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Text(model.id.description)
                    .font(.subheadline)
            }
            Text(model.number)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(model.expiryDate)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#if DEBUG

#Preview("CreditCardView") {
    CreditCardView(
        model: CreditCard(
            id: 123,
            uid: "abc-123-def-456",
            number: "123456789",
            expiryDate: "tomorrow",
            type: .visa
        )
    )
}

#endif
