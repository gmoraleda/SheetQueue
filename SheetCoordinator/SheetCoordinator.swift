//
//  SheetCoordinator.swift
//  SheetCoordinator
//
//  Created by Moraleda, Guillermo (ABI) on 02.07.24.
//

import SwiftUI

final class SheetCoordinator<Sheet: SheetEnum>: ObservableObject {
    @Published var currentSheet: Sheet?
    @Published var style: SheetStyle?
    @Published var sheetStack: [Sheet] = []

    @MainActor
    func presentSheets(_ sheets: [Sheet]) {
        let sortedSheets = sheets.sorted { $0.priority.rawValue > $1.priority.rawValue }
        sortedSheets.forEach { presentSheet($0) }
    }

    @MainActor
    func presentSheet(_ sheet: Sheet) {
        sheetStack.append(sheet)
        sheetStack.sort { $0.priority.rawValue > $1.priority.rawValue }

        if sheetStack.count == 1 {
            print("count == 1")
            style = sheet.style
            currentSheet = sheet
        } else {
            print("count != 1, sheetStack: \(sheetStack)")
        }

        print("presentSheet: \(sheet)")
        print("sheetStack: \(sheetStack)")
        print("currentSheet: \(currentSheet.debugDescription)")
    }

    @MainActor
    func sheetDismissed() {
        print("sheetDismissed, before dismissed", "sheetStack: \(sheetStack)")

        guard !sheetStack.isEmpty else { return }

        sheetStack.removeFirst()

        if let nextSheet = sheetStack.first {
            currentSheet = nextSheet
        } else {
            currentSheet = nil
            style = nil
        }

        print("sheetDismissed, after dismissed", "sheetStack: \(sheetStack)")
        print("currentSheet: \(currentSheet.debugDescription)")
    }
}
