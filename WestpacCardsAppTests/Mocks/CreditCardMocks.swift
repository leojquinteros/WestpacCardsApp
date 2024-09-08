//
//  CreditCardMocks.swift
//  WestpacCardsAppTests
//
//  Created by Leo Quinteros on 08/09/2024.
//

import Foundation
@testable import WestpacCardsApp

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
