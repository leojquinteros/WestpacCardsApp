//
//  CreditCardListViewModel.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import Foundation

enum ViewState: Equatable {
    case loading
    case loaded(result: [CreditCard])
    case error(message: String)
}

class CreditCardListViewModel: ObservableObject {
    @Published var state: ViewState = .loading
    
    private let service: CreditCardServiceProtocol
    
    init(service: CreditCardServiceProtocol = CreditCardService()) {
        self.service = service
    }
 
    @MainActor
    func loadCreditCards() async {
        state = .loading
        let result = await service.fetch()
        switch result {
        case .failure(let error):
            state = .error(message: error.localizedDescription)
        case .success(let result):
            state = .loaded(result: result)
        }
    }
}
