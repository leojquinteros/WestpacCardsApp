//
//  CreditCardListViewModelTests.swift
//  WestpacCardsAppTests
//
//  Created by Leo Quinteros on 06/09/2024.
//

import XCTest
@testable import WestpacCardsApp

final class CreditCardListViewModelTests: XCTestCase {

    private var viewModel: CreditCardsViewModel!
    private var mockService: MockCreditCardService!

    override func setUp() {
        super.setUp()
        mockService = MockCreditCardService()
        viewModel = CreditCardsViewModel(service: mockService, favouritesManager: MockFavouritesManager())
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testSuccessfullyLoadedCreditCards() async {
        let creditCards = [
            CreditCard(id: 123, uid: "abc-123-def-456", number: "123456789", expiryDate: Date(), type: .visa),
            CreditCard(id: 456, uid: "abc-123-def-457", number: "341234567", expiryDate: Date(), type: .visa),
            CreditCard(id: 789, uid: "abc-123-def-458", number: "145678934", expiryDate: Date(), type: .americanExpress),
            CreditCard(id: 111, uid: "abc-123-def-459", number: "343434344", expiryDate: Date(), type: .visa)
        ]
        mockService.result = .success(creditCards)

        await viewModel.loadCreditCards()

        XCTAssertEqual(viewModel.state, .loaded(result: creditCards))
    }

    func testErrorFetchingCreditCards() async {
        mockService.result = .failure(.invalidRequestError)

        await viewModel.loadCreditCards()

        XCTAssertEqual(viewModel.state, .error(message: "Invalid Request"))
    }
}

private class MockCreditCardService: CreditCardServiceProtocol {
    var url: URL?

    var result: Result<[CreditCard], ServiceError>?

    func fetch() async -> Result<[CreditCard], ServiceError> {
        result ?? .failure(.invalidRequestError)
    }
}

private class MockFavouritesManager: FavouritesManagerProtocol {
    var favourites: [CreditCard] = []

    func add(_ card: CreditCard) { }
    func remove(_ cardID: Int) { }
}
