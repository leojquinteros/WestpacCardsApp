//
//  CreditCardMocks.swift
//  WestpacCardsAppTests
//
//  Created by Leo Quinteros on 08/09/2024.
//

import Foundation
@testable import WestpacCardsApp

struct CreditCardMocks {
    static var list: [CreditCard] {
        let expiryDate = DateFormatter.core.date(from: "2026-09-05")!
        return [
            CreditCard(id: 123, uid: "abc-123-def-456", number: "123456789", expiryDate: expiryDate, type: .visa),
            CreditCard(id: 456, uid: "abc-123-def-457", number: "341234567", expiryDate: expiryDate, type: .visa),
            CreditCard(id: 789, uid: "abc-123-def-458", number: "145678934", expiryDate: expiryDate, type: .americanExpress),
            CreditCard(id: 111, uid: "abc-123-def-459", number: "343434344", expiryDate: expiryDate, type: .americanExpress)
        ]
    }
}

class MockCreditCardService: CreditCardServiceProtocol {
    var url: URL?

    var result: Result<[CreditCard], ServiceError>?

    func fetch() async -> Result<[CreditCard], ServiceError> {
        result ?? .failure(.invalidRequestError)
    }
}

class MockFavouritesManager: FavouritesManagerProtocol {
    var favourites: [CreditCard] = []

    func add(_ card: CreditCard) { }
    func remove(_ cardID: Int) { }
}
