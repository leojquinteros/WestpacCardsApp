//
//  FavouritesManager.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 06/09/2024.
//

import Foundation

protocol FavouritesManagerProtocol {
    func add(_ card: CreditCard)
    func remove(_ cardID: Int)
}

final class FavouritesManager: FavouritesManagerProtocol {
    private let key = "cc-favourites-key"
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    var favourites: [CreditCard] {
        if
            let saved = userDefaults.data(forKey: key),
            let favourites = try? JSONDecoder().decode([CreditCard].self, from: saved)
        {
            return favourites
        }
        return []
    }

    func add(_ cc: CreditCard) {
        var creditCardList = favourites
        if !creditCardList.contains(where: { $0.id == cc.id }) {
            creditCardList.append(cc)
            saveFavourites(creditCardList)
        }
    }

    func remove(_ cardID: Int) {
        var creditCardList = favourites
        if let index = creditCardList.firstIndex(where: { $0.id == cardID }) {
            creditCardList.remove(at: index)
            saveFavourites(creditCardList)
        }
    }

    private func saveFavourites(_ creditCardList: [CreditCard]) {
        if creditCardList.isEmpty {
            userDefaults.removeObject(forKey: key)
        } else {
            if let encodedData = try? JSONEncoder().encode(creditCardList) {
                userDefaults.set(encodedData, forKey: key)
            }
        }
    }
}
