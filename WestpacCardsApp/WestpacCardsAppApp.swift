//
//  WestpacCardsAppApp.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import SwiftUI

@main
struct WestpacCardsAppApp: App {
    var body: some Scene {
        WindowGroup {
            CreditCardListView(viewModel: CreditCardListViewModel())
        }
    }
}
