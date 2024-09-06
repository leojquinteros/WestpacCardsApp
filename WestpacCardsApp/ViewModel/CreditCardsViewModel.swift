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
    case grouped(result: [GroupedCreditCard])
    case error(message: String)
}

class CreditCardsViewModel: ObservableObject {
    @Published var state: ViewState = .loading
    
    private let service: CreditCardServiceProtocol
    private let favouritesManager: FavouritesManagerProtocol
    private var fetchedCards: [CreditCard]? = nil
    
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
    
    func list() {
        guard let fetchedCards else { return }
        state = .loaded(result: fetchedCards)
    }
    
    func grouped() {
        guard let fetchedCards else { return }
        let grouped = Dictionary(grouping: fetchedCards, by: { $0.type })
            .sorted(by: {
                $0.key.description < $1.key.description
            })
            .map {
                GroupedCreditCard(key: $0, value: $1.sorted(by: { $0.id < $1.id }))
            }
        state = .grouped(result: grouped)
    }
}

#if DEBUG

class MockCreditCardService: CreditCardServiceProtocol {
    var url: URL?
    var mockError: ServiceError?
    var mockCards: [CreditCard] = [
        CreditCard(id: 123, uid: "abc-123-def-456", number: "123456789", expiryDate: "tomorrow", type: .visa),
        CreditCard(id: 456, uid: "abc-123-def-457", number: "341234567", expiryDate: "", type: .visa),
        CreditCard(id: 789, uid: "abc-123-def-458", number: "145678934", expiryDate: "", type: .americanExpress),
        CreditCard(id: 111, uid: "abc-123-def-459", number: "343434344", expiryDate: "12-12-2024", type: .visa)
    ]
    
    func fetch() async -> Result<[CreditCard], ServiceError> {
        if let mockError {
            return .failure(mockError)
        }
        return .success(mockCards)
    }
}

class MockFavouritesManager: FavouritesManagerProtocol {
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
