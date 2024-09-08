//
//  LocalCreditCardService.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import Foundation

class LocalCreditCardService: CreditCardServiceProtocol {
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
        self.decoder.dateDecodingStrategy = .formatted(.core)
    }

    func fetch() async -> Result<[CreditCard], ServiceError> {
        do {
            // emulate API fetch delay
            try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
        } catch {
            return .failure(.transportError(error))
        }
        do {
            let data = try await creditCardsData()
            let response = try decoder.decode([CreditCard].self, from: data)
            return .success(response)
        } catch let error as ServiceError {
            return .failure(error)
        } catch {
            return .failure(.decodingError(error))
        }
    }
    
    private func creditCardsData() async throws -> Data {
        guard let fileURL = url else {
            throw ServiceError.invalidRequestError
        }
        do {
            return try Data(contentsOf: fileURL)
        } catch {
            throw ServiceError.transportError(error)
        }
    }
    
    var url: URL? {
        guard let filePath = Bundle.main.path(forResource: "creditcards", ofType: "json") else {
            return nil
        }
        return URL(fileURLWithPath: filePath)
    }
}
