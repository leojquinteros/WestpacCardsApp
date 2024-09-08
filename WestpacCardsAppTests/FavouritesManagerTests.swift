//
//  FavouritesManagerTests.swift
//  WestpacCardsAppTests
//
//  Created by Leo Quinteros on 06/09/2024.
//

import XCTest
@testable import WestpacCardsApp

final class FavouritesManagerTests: XCTestCase {
    
    var favouritesManager: FavouritesManager!
    var mockUserDefaults: UserDefaults!
    
    override func setUpWithError() throws {
        mockUserDefaults = UserDefaults(suiteName: "cc-test-suite-name")
        mockUserDefaults.removePersistentDomain(forName: "cc-test-suite-name")
        favouritesManager = FavouritesManager(userDefaults: mockUserDefaults)
    }
    
    override func tearDownWithError() throws {
        mockUserDefaults.removePersistentDomain(forName: "cc-test-suite-name")
        mockUserDefaults = nil
        favouritesManager = nil
    }
    
    func testAddCardToFavourites() {
        let card = CreditCard(id: 12, uid: "abc-123", number: "123456", expiryDate: Date(), type: .visa)
        
        favouritesManager.add(card)
        
        let favourites = favouritesManager.favourites
        XCTAssertEqual(favourites.count, 1)
        XCTAssertEqual(favourites.first?.id, card.id)
    }
    
    func testAddSameCardToFavourites() {
        let card = CreditCard(id: 12, uid: "abc-123", number: "123456", expiryDate: Date(), type: .visa)
        
        for _ in 1...5 {
            favouritesManager.add(card)
        }
        
        let favourites = favouritesManager.favourites
        XCTAssertEqual(favourites.count, 1)
        XCTAssertEqual(favourites.first?.id, card.id)
    }
    
    func testAddAndThenRemoveCard() {
        let card = CreditCard(id: 12, uid: "abc-123", number: "123456", expiryDate: Date(), type: .visa)
        
        favouritesManager.add(card)
        favouritesManager.remove(card.id)
        
        let favourites = favouritesManager.favourites
        XCTAssertTrue(favourites.isEmpty)
    }
    
    func testRemoveNonExistingCard() {
        let card = CreditCard(id: 12, uid: "abc-123", number: "123456", expiryDate: Date(), type: .visa)
        favouritesManager.add(card)

        favouritesManager.remove(123)
        
        let favourites = favouritesManager.favourites
        XCTAssertEqual(favourites.count, 1)
        XCTAssertEqual(favourites.first?.id, card.id)
    }
    
    func testEmptyFavourites() {
        let favourites = favouritesManager.favourites
        
        XCTAssertTrue(favourites.isEmpty)
    }
}
