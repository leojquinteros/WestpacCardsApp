//
//  ServiceError.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import Foundation

enum ServiceError: LocalizedError {
    case invalidRequestError
    case transportError(Error)
    case decodingError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidRequestError:
            return "Invalid Request"
        case .transportError(let error):
            return "Transport Error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Decoding Error: \(error.localizedDescription)"
        }
    }
}
