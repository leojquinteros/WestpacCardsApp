//
//  CreditCardService.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import Foundation

protocol CreditCardServiceProtocol {
    var url: URL? { get }
    func fetch() async -> Result<[CreditCard], ServiceError>
}

class CreditCardService: CreditCardServiceProtocol {
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func fetch() async -> Result<[CreditCard], ServiceError> {
        guard let url = url else {
            return .failure(.invalidRequestError)
        }
        var data: Data
        do {
            data = try await URLSession.shared.data(from: url).0
        } catch {
            return .failure(.transportError(error))
        }
        var response: [CreditCard]
        do {
            response = try decoder.decode([CreditCard].self, from: data)
        } catch {
            return .failure(.decodingError(error))
        }
        return .success(response)
    }
    
    var url: URL? {
        URL(string: "https://random-data-api.com/api/v2/credit_cards?size=100")
    }
}
