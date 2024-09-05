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
    
    init(service: CreditCardServiceProtocol = LocalCreditCardService()) {
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

#if DEBUG

class MockCreditCardService: CreditCardServiceProtocol {
    var url: URL?
    var mockError: ServiceError?
    var mockCards: [CreditCard] = [
        CreditCard(id: 123, uid: "abc-123-def-456", number: "123456789", expiryDate: "tomorrow", type: "visa"),
        CreditCard(id: 456, uid: "abc-123-def-457", number: "341234567", expiryDate: "", type: "mastercard"),
        CreditCard(id: 789, uid: "abc-123-def-458", number: "145678934", expiryDate: "", type: "mastercard"),
        CreditCard(id: 111, uid: "abc-123-def-459", number: "343434344", expiryDate: "12-12-2024", type: "visa")
    ]
    
    func fetch() async -> Result<[CreditCard], ServiceError> {
        if let mockError {
            return .failure(mockError)
        }
        return .success(mockCards)
    }
}

extension CreditCardListViewModel: Mockable {
    
    static var mock: CreditCardListViewModel {
        CreditCardListViewModel(service: MockCreditCardService())
    }
}

#endif
