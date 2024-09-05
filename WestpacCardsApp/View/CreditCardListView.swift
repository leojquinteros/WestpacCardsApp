//
//  CreditCardListView.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import SwiftUI

struct CreditCardListView: View {
    
    @ObservedObject var viewModel: CreditCardListViewModel
    
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
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(cards, id: \.self) { cc in
                            CreditCardView(model: cc)
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.loadCreditCards()
        }
    }
}

#if DEBUG

#Preview("Credit card list") {
    CreditCardListView(viewModel: CreditCardListViewModel.mock)
}

#endif
