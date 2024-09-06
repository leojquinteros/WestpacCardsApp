//
//  CreditCardListView.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 06/09/2024.
//

import SwiftUI

struct CreditCardListView: View {
    let cards: [CreditCard]
    let viewModel: CreditCardsViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(cards, id: \.self) { card in
                    CreditCardView(model: card)
                        .swipeActions(allowsFullSwipe: false) {
                            Button {
                                viewModel.saveToFavourites(card)
                            } label: {
                                Label("Save", symbol: .star)
                            }
                            .tint(.yellow)
                        }
                }
            }
            .navigationTitle("Card list")
            .toolbar {
                Button("Group") {
                    viewModel.grouped()
                }
            }
        }
    }
}

#if DEBUG

#Preview {
    CreditCardListView(cards: [
        CreditCard(
            id: 123,
            uid: "abc-123-def-456",
            number: "123456789",
            expiryDate: "tomorrow",
            type: .visa
        ),
        CreditCard(
            id: 123,
            uid: "abc-123-def-456",
            number: "123456789",
            expiryDate: "tomorrow",
            type: .visa
        )
    ], viewModel: CreditCardsViewModel.mock)
}

#endif
