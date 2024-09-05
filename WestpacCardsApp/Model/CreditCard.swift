//
//  CreditCard.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import Foundation

struct CreditCard: Hashable, Decodable, Identifiable {
    let id: Int
    let uid: String
    let number: String
    let expiryDate: String
    let type: String
    
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
        self.type = try container.decode(String.self, forKey: .type)
    }
    
}
