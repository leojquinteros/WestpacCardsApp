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
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.creditCardList, id: \.self) { cc in
                    CreditCardView(model: cc)
                }
            }
        }
        .task {
            await viewModel.loadCreditCards()
        }
    }
}

private struct CreditCardView: View {
    var model: CreditCard
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.type)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Text(model.number)
                .foregroundColor(.primary)
                .lineLimit(1)
            Text(model.expiryDate)
                .foregroundColor(.primary)
                .lineLimit(1)
        }
        .padding()
    }
}

#Preview {
    CreditCardListView(viewModel: CreditCardListViewModel())
}
