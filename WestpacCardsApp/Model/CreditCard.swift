//
//  CreditCard.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import Foundation

struct GroupedCreditCard: Equatable {
    let key: CreditCardType
    let value: [CreditCard]
}

struct CreditCard: Hashable, Codable, Identifiable {
    let id: Int
    let uid: String
    let number: String
    let expiryDate: String
    let type: CreditCardType
    
    init(id: Int, uid: String, number: String, expiryDate: String, type: CreditCardType) {
        self.id = id
        self.uid = uid
        self.number = number
        self.expiryDate = expiryDate
        self.type = type
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case number = "credit_card_number"
        case expiryDate = "credit_card_expiry_date"
        case type = "credit_card_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.uid = try container.decode(String.self, forKey: .uid)
        self.number = try container.decode(String.self, forKey: .number)
        self.expiryDate = try container.decode(String.self, forKey: .expiryDate)
        let rawCardType = try container.decode(String.self, forKey: .type)
        if let cardType = CreditCardType(rawValue: rawCardType) {
             self.type = cardType
        } else {
            throw DecodingError.dataCorrupted(.init(
                codingPath: decoder.codingPath,
                debugDescription: "Cannot initialize CreditCardType from value \(rawCardType)")
            )
        }
    }
}

enum CreditCardListType: CaseIterable {
    case all
    case grouped
    case favourites
}

extension CreditCardListType {
    var description: String {
        switch self {
        case .all:
            "All"
        case .grouped:
            "Grouped by type"
        case .favourites:
            "Favourites"
        }
    }
}
