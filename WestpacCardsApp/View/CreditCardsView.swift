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
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .loading:
                    LoadingView()
                case .error(let message):
                    CreditCardsUnavailable(
                        symbol: .error,
                        title: "Error retrieving cards",
                        message: message,
                        actionTitle: "Try again"
                    ) {
                        Task(priority: .userInitiated) {
                            await viewModel.loadCreditCards()
                        }
                    }
                case .loaded(let cards):
                    CreditCardListView(
                        cards: cards,
                        onFavorite: { card in
                            viewModel.saveToFavourites(card)
                        }, 
                        onRefresh: {
                            Task(priority: .userInitiated) {
                                await viewModel.loadCreditCards()
                            }
                        }
                    )
                case .favourites(let cards):
                    FavouritesListView(cards: cards) { card in
                        viewModel.removeFromFavourites(card)
                    }
                case .grouped(let cardsDictionary):
                    GroupedCreditCardListView(cards: cardsDictionary) { card in
                        viewModel.saveToFavourites(card)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CardViewSelector(selection: $viewModel.selectedListType)
                        .disabled(viewModel.state == .loading)
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

#Preview {
    CreditCardsView(viewModel: CreditCardsViewModel.mock)
}

#endif
