//
//  CreditCardListView.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import SwiftUI

struct CreditCardsView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel: CreditCardsViewModel
    @State var viewOpacity: Double = 100.0
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                LoadingView()
            case .error(let message):
                CreditCardsUnavailable(
                    symbol: .error,
                    title: "Error retrieving cards",
                    message: message
                )
            case .loaded(let cards):
                CreditCardListView(cards: cards) { card in
                    viewModel.saveToFavourites(card)
                }
            case .grouped(let cardsDictionary):
                GroupedCreditCardListView(cards: cardsDictionary) { card in
                    viewModel.saveToFavourites(card)
                }
            }
        }
        .opacity(viewOpacity)
        .task {
            await viewModel.loadCreditCards()
        }
        .onChange(of: scenePhase) { _, newPhase in
            viewOpacity = newPhase == .active ? 100.0 : 0.0
        }
    }
}

#if DEBUG

#Preview("Credit cards view") {
    CreditCardsView(viewModel: CreditCardsViewModel.mock)
}

#endif
