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
            Text(model.type.description)
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
