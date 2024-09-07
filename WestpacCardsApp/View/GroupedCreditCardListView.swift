//
//  GroupedCreditCardListView.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 06/09/2024.
//

import SwiftUI

struct GroupedCreditCardListView: View {
    let cards: [GroupedCreditCard]
    let onFavorite: (CreditCard) -> Void
    let onGroup: (() -> Void)?
    
    init(cards: [GroupedCreditCard], onFavorite: @escaping (CreditCard) -> Void, onGroup: (() -> Void)? = nil) {
        self.cards = cards
        self.onFavorite = onFavorite
        self.onGroup = onGroup
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(cards, id: \.key) { card in
                    Section(header: Text(card.key.description)) {
                        ForEach(card.value, id: \.self) { card in
                            CreditCardView(model: card)
                                .swipeActions(allowsFullSwipe: false) {
                                    Button {
                                        onFavorite(card)
                                    } label: {
                                        Label("Save", symbol: .star)
                                    }
                                    .tint(.yellow)
                                }
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .navigationTitle("Grouped cards")
            .toolbar {
                Button("List") {
                    onGroup?()
                }
            }
            .listStyle(.plain)
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
    ]) { _ in }
}
