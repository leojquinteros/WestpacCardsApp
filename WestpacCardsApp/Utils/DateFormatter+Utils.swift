//
//  DateFormatter+Utils.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 08/09/2024.
//

import Foundation

private enum DateFormat: String {
    case cardList = "yyyy-MM-dd"
    case prettified = "MMM d, yyyy"
}

public extension DateFormatter {
    static var core: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.cardList.rawValue
        formatter.locale =  Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

private extension DateFormatter {
    static var prettified: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.prettified.rawValue
        formatter.locale =  Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

public extension Date {
    func dateFormatted() -> String {
        DateFormatter.prettified.string(from: self)
    }
}
