//
//  FavouritesListView.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 06/09/2024.
//

import SwiftUI

struct FavouritesListView: View {
    let cards: [CreditCard]
    let onFavorite: (CreditCard) -> Void
    
    init(cards: [CreditCard], onFavorite: @escaping (CreditCard) -> Void) {
        self.cards = cards
        self.onFavorite = onFavorite
    }
    
    var body: some View {
        List {
            ForEach(cards, id: \.self) { card in
                CreditCardView(model: card)
                    .swipeActions(allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            onFavorite(card)
                        } label: {
                            Label("Remove", symbol: .remove)
                        }
                    }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle("Favourites")
    }
}

#if DEBUG

#Preview {
    FavouritesListView(cards: [
        CreditCard(id: 123, uid: "abc", number: "123", expiryDate: Date(), type: .visa),
        CreditCard(id: 123, uid: "abc", number: "123", expiryDate: Date(), type: .visa),
        CreditCard(id: 123, uid: "abc", number: "123", expiryDate: Date(), type: .visa)
    ]) { _ in }
}

#endif
