//
//  CreditCardListView.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 06/09/2024.
//

import SwiftUI

struct CreditCardListView: View {
    let cards: [CreditCard]
    let onFavorite: (CreditCard) -> Void
    let onGroup: (() -> Void)?
    
    init(cards: [CreditCard], onFavorite: @escaping (CreditCard) -> Void, onGroup: (() -> Void)? = nil) {
        self.cards = cards
        self.onFavorite = onFavorite
        self.onGroup = onGroup
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(cards, id: \.self) { card in
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
                .listRowSeparator(.hidden)
            }
            .navigationTitle("Card list")
            .toolbar {
                Button("Group") {
                    onGroup?()
                }
            }
            .listStyle(.plain)
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
    ]) { _ in }
}

#endif
