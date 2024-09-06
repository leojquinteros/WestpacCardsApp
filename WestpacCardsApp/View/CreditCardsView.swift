//
//  CreditCardListView.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import SwiftUI

struct CreditCardsView: View {
    
    @ObservedObject var viewModel: CreditCardsViewModel
    
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
                CreditCardListView(cards: cards, viewModel: viewModel)
            case .grouped(let cardsDictionary):
                GroupedCreditCardListView(cards: cardsDictionary, viewModel: viewModel)
            }
        }
        .task {
            await viewModel.loadCreditCards()
        }
    }
}

#if DEBUG

#Preview("Credit cards view") {
    CreditCardsView(viewModel: CreditCardsViewModel.mock)
}

#endif
