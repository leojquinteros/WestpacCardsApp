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
        self.decoder.dateDecodingStrategy = .formatted(.core)
    }
    
    func fetch() async -> Result<[CreditCard], ServiceError> {
        guard let url = url else {
            return .failure(.invalidRequestError)
        }
        var data: Data
        var urlResponse: URLResponse
        do {
            let (fetchedData, response) = try await URLSession.shared.data(from: url)
            data = fetchedData
            urlResponse = response
        } catch {
            return .failure(.transportError(error))
        }
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            return .failure(.unknownError)
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            return .failure(.httpError(httpResponse.statusCode))
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
