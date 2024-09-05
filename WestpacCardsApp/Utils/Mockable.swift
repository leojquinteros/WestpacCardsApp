//
//  Mockable.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import Foundation

protocol Mockable {
    associatedtype MockType
    static var mock: MockType { get }
}
