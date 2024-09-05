//
//  CreditCardType.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 06/09/2024.
//

import Foundation

enum CreditCardType: String {
    case visa
    case mastercard
    case maestro
    case solo
    case dankort
    case laser
    case discover
    case jcb
    case forbrugsforeningen
    case `switch`
    case americanExpress = "american_express"
    case dinersClub = "diners_club"
}

extension CreditCardType {
    
    var description: String {
        switch self {
        case .visa: "Visa"
        case .mastercard: "Mastercard"
        case .maestro: "Maestro"
        case .solo: "Solo"
        case .dankort: "Dankort"
        case .laser: "Laser"
        case .discover: "Discover"
        case .jcb: "JCB"
        case .forbrugsforeningen: "Forbrugsforeningen"
        case .switch: "Switch"
        case .americanExpress: "American Express"
        case .dinersClub: "Diners Club"
        }
    }
}
