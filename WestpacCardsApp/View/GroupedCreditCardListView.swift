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
        .listStyle(.plain)
        .navigationTitle("Grouped cards")
    }
}

#if DEBUG

#Preview {
    GroupedCreditCardListView(cards: [
        GroupedCreditCard(key: .visa, value: [
            CreditCard(id: 1, uid: "abc", number: "123", expiryDate: Date(), type: .visa),
            CreditCard(id: 2, uid: "abc", number: "123", expiryDate: Date(), type: .visa),
            CreditCard(id: 3, uid: "abc", number: "123", expiryDate: Date(), type: .visa)
        ]),
        GroupedCreditCard(key: .maestro, value: [
            CreditCard(id: 4, uid: "abc", number: "123", expiryDate: Date(), type: .maestro),
            CreditCard(id: 5, uid: "abc", number: "123", expiryDate: Date(), type: .maestro),
            CreditCard(id: 6, uid: "abc", number: "123", expiryDate: Date(), type: .maestro)
        ])
    ]) { _ in }
}

#endif
