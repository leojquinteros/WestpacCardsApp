//
//  DateFormatterTests.swift
//  WestpacCardsAppTests
//
//  Created by Leo Quinteros on 08/09/2024.
//

import XCTest
@testable import WestpacCardsApp

final class DateFormatterTests: XCTestCase {
    
    func testCardListDateFormatter() {
        let expectedDate = DateComponents(calendar: Calendar.current, year: 2026, month: 9, day: 5).date!
        let date = DateFormatter.core.date(from: "2026-09-05")
        
        XCTAssertNotNil(date)
        XCTAssertEqual(date, expectedDate)
    }
    
    func testDateFormatted() {
        let date = DateFormatter.core.date(from: "2026-09-05")!
        let expectedFormattedString = "Sep 5, 2026"
        
        let prettifiedString = date.dateFormatted()
        
        XCTAssertEqual(prettifiedString, expectedFormattedString)
    }
}
