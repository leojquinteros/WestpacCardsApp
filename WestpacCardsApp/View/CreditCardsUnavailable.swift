//
//  CreditCardsUnavailable.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import SwiftUI

struct CreditCardsUnavailable: View {
    let symbol: SFSymbol
    let title: String
    let message: String
    let actionTitle: String?
    let action: (() -> Void)?
    
    init(symbol: SFSymbol, title: String, message: String, actionTitle: String? = nil, action: (() -> Void)? = nil) {
        self.symbol = symbol
        self.title = title
        self.actionTitle = actionTitle
        self.message = message
        self.action = action
    }
    
    var body: some View {
        if #available(iOS 17.0, *) {
            ContentUnavailableView {
                Label(title, symbol: symbol)
            } description: {
                Text(message)
            } actions: {
                if let actionTitle, let action {
                    Button(actionTitle) {
                        action()
                    }
                }
            }
        } else {
            VStack {
                Label(title, symbol: symbol)
                    .font(.title)
                    .padding(.bottom, 10)
                
                Text(message)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
            
                if let actionTitle, let action {
                    Button(actionTitle) {
                        action()
                    }
                }
            }
            .padding()
            .cornerRadius(15)
            .shadow(radius: 5)
        }
    }
}

#Preview("CreditCardsUnavailable with action") {
    CreditCardsUnavailable(
        symbol: .error,
        title: "Unable to show card list",
        message: "Description: Service temporarily down",
        actionTitle: "Try again",
        action: { }
    )
}

#Preview("CreditCardsUnavailable with no action") {
    CreditCardsUnavailable(
        symbol: .error,
        title: "Unable to show card list",
        message: "Description: Decoding error"
    )
}
