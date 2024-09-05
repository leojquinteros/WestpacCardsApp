//
//  CreditCardListViewModel.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import Foundation

class CreditCardListViewModel: ObservableObject {
    @Published var creditCardList = [CreditCard]()
    
    private let service: CreditCardServiceProtocol
    
    init(service: CreditCardServiceProtocol = CreditCardService()) {
        self.service = service
    }
 
    @MainActor
    func loadCreditCards() async {
        let result = await service.fetch()
        switch result {
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        case .success(let result):
            creditCardList = result
        }
    }
}
