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
    let onRefresh: () -> Void
    
    init(cards: [CreditCard], onFavorite: @escaping (CreditCard) -> Void, onRefresh: @escaping () -> Void) {
        self.cards = cards
        self.onFavorite = onFavorite
        self.onRefresh = onRefresh
    }
    
    var body: some View {
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
        .listStyle(.plain)
        .navigationTitle("Credit cards")
        .refreshable {
            onRefresh()
        }
    }
}

#if DEBUG

#Preview {
    CreditCardListView(
        cards: [
            CreditCard(id: 123, uid: "abc", number: "123", expiryDate: Date(), type: .visa),
            CreditCard(id: 123, uid: "abc", number: "123", expiryDate: Date(), type: .visa),
            CreditCard(id: 123, uid: "abc", number: "123", expiryDate: Date(), type: .visa)
        ],
        onFavorite: { _ in },
        onRefresh: { }
    )
}

#endif
