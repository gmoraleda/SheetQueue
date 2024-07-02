//
//  SheetEnum.swift
//  SheetCoordinator
//
//  Created by Moraleda, Guillermo (ABI) on 02.07.24.
//

import SwiftUI

enum SheetPriority {
    case defaultHigh
    case defaultLow
    case custom(Int)

    var rawValue: Int {
        switch self {
        case .defaultHigh:
            return 100
        case .defaultLow:
            return 0
        case let .custom(value):
            return value
        }
    }

    init?(rawValue: Int) {
        switch rawValue {
        case 100:
            self = .defaultHigh
        case 0:
            self = .defaultLow
        default:
            self = .custom(rawValue)
        }
    }
}

enum SheetStyle {
    case sheet, fullScreenCover
}

protocol SheetEnum: Identifiable, Equatable {
    associatedtype Body: View

    var priority: SheetPriority { get }
    var style: SheetStyle { get }

    @ViewBuilder
    func view(coordinator: SheetCoordinator<Self>) -> Body
}
