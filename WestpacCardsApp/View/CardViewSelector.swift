//
//  CardViewSelector.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 07/09/2024.
//

import SwiftUI

struct CardViewSelector: View {
    
    let selection: Binding<CreditCardListType?>
    
    var body: some View {
        Menu {
            Picker("List type", selection: selection) {
                ForEach(CreditCardListType.allCases, id: \.self) {
                    Text($0.description).tag($0 as CreditCardListType?)
                }
            }
        } label: {
            Label("List type", symbol: .editList)
                .font(.headline)
                .padding(8)
        }
    }
}

#if DEBUG

#Preview {
    CardViewSelector(selection: .constant(.all))
        .previewLayout(.sizeThatFits)
}

#endif
