//
//  GroupedCreditCardListView.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 06/09/2024.
//

import SwiftUI

struct GroupedCreditCardListView: View {
    
    let cards: [GroupedCreditCard]
    let viewModel: CreditCardsViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(cards, id: \.key) { card in
                    Section(header: Text(card.key.description)) {
                        ForEach(card.value, id: \.self) { card in
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
                }
            }
            .navigationTitle("Grouped cards")
            .toolbar {
                Button("List") {
                    viewModel.list()
                }
            }
        }
    }
}

#Preview {
    GroupedCreditCardListView(cards: [
        GroupedCreditCard(key: .visa, value: [
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
        ])
    ], viewModel: CreditCardsViewModel.mock)
}
