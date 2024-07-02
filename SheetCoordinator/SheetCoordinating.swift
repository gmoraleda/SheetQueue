//
//  SheetCoordinating.swift
//  SheetCoordinator
//
//  Created by Moraleda, Guillermo (ABI) on 02.07.24.
//

import SwiftUI

struct SheetCoordinating<Sheet: SheetEnum>: ViewModifier {
    @StateObject var coordinator: SheetCoordinator<Sheet>

    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .sheet(item: matches(style: .sheet), onDismiss: {
                coordinator.sheetDismissed()
            }, content: { sheet in
                sheet.view(coordinator: coordinator)
            })
            .fullScreenCover(item: matches(style: .fullScreenCover), onDismiss: {
                coordinator.sheetDismissed()
            }, content: { sheet in
                sheet.view(coordinator: coordinator)
            })
    }

    func matches(style: SheetStyle) -> Binding<Sheet?> {
        return coordinator.currentSheet?.style == style ? $coordinator.currentSheet : .constant(nil)
    }
}
