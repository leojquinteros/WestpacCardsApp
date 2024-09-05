//
//  SFSymbol+Utils.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import SwiftUI

enum SFSymbol: String {
    case star = "star.fill"
    case error = "exclamationmark"
}

extension Image {
    init(symbol: SFSymbol) {
        self.init(systemName: symbol.rawValue)
    }
}

extension Label where Title == Text, Icon == Image {
    init(_ titleKey: String, symbol: SFSymbol) {
        self.init(titleKey, systemImage: symbol.rawValue)
    }
}
