//
//  CreditCardsViewModelTests.swift
//  WestpacCardsAppTests
//
//  Created by Leo Quinteros on 06/09/2024.
//

import XCTest
@testable import WestpacCardsApp

final class CreditCardsViewModelTests: XCTestCase {

    private var viewModel: CreditCardsViewModel!
    private var mockService: MockCreditCardService!
    private var mockManager: MockFavouritesManager!
    
    private let mockExpiryDate = DateFormatter.core.date(from: "2026-09-05")!

    override func setUp() {
        super.setUp()
        mockService = MockCreditCardService()
        mockManager = MockFavouritesManager()
        viewModel = CreditCardsViewModel(service: mockService, favouritesManager: mockManager)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockManager = nil
        super.tearDown()
    }

    func testSuccessfullyLoadedCreditCards() async {
        let creditCards = CreditCardMocks.list
        mockService.result = .success(creditCards)

        await viewModel.loadCreditCards()

        XCTAssertEqual(viewModel.state, .loaded(result: creditCards))
    }
    
    func testAllCreditCards() async {
        let creditCards = CreditCardMocks.list
        mockService.result = .success(creditCards)

        await viewModel.loadCreditCards()
        viewModel.selectedListType = .all

        XCTAssertEqual(viewModel.state, .loaded(result: creditCards))
    }
    
    func testGroupedCreditCards() async {
        let creditCards = CreditCardMocks.list
        mockService.result = .success(creditCards)

        await viewModel.loadCreditCards()
        viewModel.selectedListType = .grouped
        
        let groupedCreditCards: [GroupedCreditCard] = [
            .init(key: .americanExpress, value: [
                CreditCard(id: 789, uid: "abc-123-def-458", number: "145678934", expiryDate: mockExpiryDate, type: .americanExpress),
                CreditCard(id: 111, uid: "abc-123-def-459", number: "343434344", expiryDate: mockExpiryDate, type: .americanExpress)
            ]),
            .init(key: .visa, value: [
                CreditCard(id: 123, uid: "abc-123-def-456", number: "123456789", expiryDate: mockExpiryDate, type: .visa),
                CreditCard(id: 456, uid: "abc-123-def-457", number: "341234567", expiryDate: mockExpiryDate, type: .visa)
                
            ])
        ]

        XCTAssertEqual(viewModel.state, .grouped(result: groupedCreditCards))
    }
    
    func testFavouritesCreditCards() async {
        let creditCards = CreditCardMocks.list
        mockService.result = .success(creditCards)
        let mockFavourites = [CreditCardMocks.list.first!]
        mockManager.favourites = mockFavourites
        
        await viewModel.loadCreditCards()
        viewModel.selectedListType = .favourites
    
        XCTAssertEqual(viewModel.state, .favourites(result: mockFavourites))
    }
    
    func testEmptyCreditCardList() async {
        mockService.result = .success([])

        await viewModel.loadCreditCards()
        viewModel.selectedListType = .all

        XCTAssertEqual(viewModel.state, .empty(
            title: "No cards to show",
            message: "The card list is empty. Try again later."
        ))
    }
    
    func testEmptyCreditCardGroups() async {
        mockService.result = .success([])

        await viewModel.loadCreditCards()
        viewModel.selectedListType = .grouped

        XCTAssertEqual(viewModel.state, .empty(
            title: "No card groups to show",
            message: "The card groups are empty. Try again later."
        ))
    }
    
    func testEmptyFavouriteCreditCards() async {
        let creditCards = CreditCardMocks.list
        mockService.result = .success(creditCards)
        mockManager.favourites = []
        
        await viewModel.loadCreditCards()
        viewModel.selectedListType = .favourites

        XCTAssertEqual(viewModel.state, .empty(
            title: "No favourites to show",
            message: "Start saving some cards to this list using swipe actions!"
        ))
    }

    func testErrorFetchingCreditCards() async {
        mockService.result = .failure(.invalidRequestError)

        await viewModel.loadCreditCards()

        XCTAssertEqual(viewModel.state, .error(message: "Invalid Request"))
    }
}

