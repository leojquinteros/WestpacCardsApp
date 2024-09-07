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
    
    init(cards: [GroupedCreditCard], onFavorite: @escaping (CreditCard) -> Void) {
        self.cards = cards
        self.onFavorite = onFavorite
    }
    
    var body: some View {
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
        .listStyle(.plain)
    }
}

#if DEBUG

#Preview {
    GroupedCreditCardListView(cards: [
        GroupedCreditCard(key: .visa, value: [
            CreditCard(id: 123, uid: "abc", number: "123", expiryDate: "1-11-1111", type: .visa),
            CreditCard(id: 123, uid: "abc", number: "123", expiryDate: "1-11-1111", type: .visa),
            CreditCard(id: 123, uid: "abc", number: "123", expiryDate: "1-11-1111", type: .visa)
        ])
    ]) { _ in }
}

#endif
