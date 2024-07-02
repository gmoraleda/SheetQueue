//
//  ContentView.swift
//  SheetCoordinator
//
//  Created by Moraleda, Guillermo (ABI) on 02.07.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var sheetCoordinator = SheetCoordinator<TestSheet>()

    var body: some View {
        VStack(spacing: 20) {
            Button("Add Multiple Sheets to Queue") {
                sheetCoordinator.presentSheets([
                    .normalPrioritySheet,
                    .highPrioritySheet,
                    .lowPriorityFullCover,
                ])
            }
            Button("Full Cover") {
                sheetCoordinator.presentSheet(.lowPriorityFullCover)
            }
        }
        .sheetCoordinating(coordinator: sheetCoordinator)
        .padding()
        .frame(width: 400, height: 300)
    }
}

#Preview {
    ContentView()
}

extension View {
    func sheetCoordinating<Sheet: SheetEnum>(coordinator: SheetCoordinator<Sheet>) -> some View {
        modifier(SheetCoordinating(coordinator: coordinator))
    }
}

// MARK: - TestSheet

enum TestSheet: String, Identifiable, SheetEnum {
    case normalPrioritySheet, highPrioritySheet, lowPriorityFullCover
    var priority: SheetPriority {
        switch self {
        case .normalPrioritySheet:
            return .custom(50)
        case .highPrioritySheet:
            return .defaultHigh
        case .lowPriorityFullCover:
            return .defaultHigh
        }
    }

    var style: SheetStyle {
        switch self {
        case .normalPrioritySheet, .highPrioritySheet:
            return .sheet
        case .lowPriorityFullCover:
            return .fullScreenCover
        }
    }

    var id: String { rawValue }

    @ViewBuilder
    @MainActor
    func view(coordinator: SheetCoordinator<TestSheet>) -> some View {
        switch self {
        case .normalPrioritySheet:
            VStack(spacing: 20) {
                Text("Normal Priority sheet")
                Text("Current sheet stack: \(coordinator.sheetStack.count)")
                buttonStack(coordinator: coordinator)
            }
        case .highPrioritySheet:
            VStack(spacing: 20) {
                Text("High Priority sheet")
                Text("Current sheet stack: \(coordinator.sheetStack.count)")
                buttonStack(coordinator: coordinator)
            }
        case .lowPriorityFullCover:
            Color.gray
                .overlay {
                    Text("Low Priority Full Cover")
                }
                .onTapGesture {
                    coordinator.currentSheet = nil
                }
                .ignoresSafeArea()
        }
    }

    @ViewBuilder
    @MainActor
    func buttonStack(coordinator: SheetCoordinator<TestSheet>) -> some View {
        Text("🛠️")
        Button("Add Normal Priority Sheet") {
            coordinator.presentSheet(.normalPrioritySheet)
        }
        Button("Add High Priority Sheet") {
            coordinator.presentSheet(.highPrioritySheet)
        }
        Button("Add Low Priority Full Cover") {
            coordinator.presentSheet(.lowPriorityFullCover)
        }
    }
}
