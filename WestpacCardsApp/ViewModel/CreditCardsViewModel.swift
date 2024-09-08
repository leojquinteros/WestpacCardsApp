//
//  CreditCardsViewModel.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import Foundation

enum ViewState: Equatable {
    case loading
    case loaded(result: [CreditCard])
    case favourites(result: [CreditCard])
    case grouped(result: [GroupedCreditCard])
    case error(message: String)
}

class CreditCardsViewModel: ObservableObject {
    @Published var state: ViewState = .loading
    @Published var selectedListType: CreditCardListType? {
        didSet {
            switch selectedListType {
            case .all, .none:
                state = .loaded(result: fetchedCards)
            case .grouped:
                state = .grouped(result: groupedCards)
            case .favourites:
                state = .favourites(result: favouritesManager.favourites)
            }
        }
    }

    private let service: CreditCardServiceProtocol
    private let favouritesManager: FavouritesManagerProtocol
    private var fetchedCards: [CreditCard] = []
    
    init(
        service: CreditCardServiceProtocol = LocalCreditCardService(),
        favouritesManager: FavouritesManagerProtocol = FavouritesManager()
    ) {
        self.service = service
        self.favouritesManager = favouritesManager
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
            fetchedCards = result
        }
    }
    
    func saveToFavourites(_ card: CreditCard) {
        favouritesManager.add(card)
    }
    
    func removeFromFavourites(_ card: CreditCard) {
        favouritesManager.remove(card.id)
    }
    
    var groupedCards: [GroupedCreditCard] {
        Dictionary(grouping: fetchedCards, by: { $0.type })
            .sorted(by: {
                $0.key.description < $1.key.description
            })
            .map {
                GroupedCreditCard(key: $0, value: $1.sorted(by: { $0.id < $1.id }))
            }
    }
}

#if DEBUG

class MockCreditCardService: CreditCardServiceProtocol {
    var url: URL?
    var mockError: ServiceError?
    var mockCards: [CreditCard] = [
        CreditCard(id: 123, uid: "abc-123-def-456", number: "123456789", expiryDate: Date(), type: .visa),
        CreditCard(id: 456, uid: "abc-123-def-457", number: "341234567", expiryDate: Date(), type: .visa),
        CreditCard(id: 789, uid: "abc-123-def-458", number: "145678934", expiryDate: Date(), type: .americanExpress),
        CreditCard(id: 111, uid: "abc-123-def-459", number: "343434344", expiryDate: Date(), type: .visa)
    ]
    
    func fetch() async -> Result<[CreditCard], ServiceError> {
        if let mockError {
            return .failure(mockError)
        }
        return .success(mockCards)
    }
}

class MockFavouritesManager: FavouritesManagerProtocol {
    var favourites: [CreditCard] = []
    func add(_ card: CreditCard) { }
    func remove(_ cardID: Int) { }
}

extension CreditCardsViewModel: Mockable {
    
    static var mock: CreditCardsViewModel {
        CreditCardsViewModel(
            service: MockCreditCardService(),
            favouritesManager: MockFavouritesManager()
        )
    }
}

#endif
