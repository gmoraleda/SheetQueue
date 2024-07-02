//
//  SheetEnum.swift
//  SheetCoordinator
//
//  Created by Moraleda, Guillermo (ABI) on 02.07.24.
//

import SwiftUI

enum SheetPriority: Int {
    case low, normal, high
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
