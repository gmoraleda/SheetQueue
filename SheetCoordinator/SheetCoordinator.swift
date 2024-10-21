import SwiftUI

protocol ModalCoordinatorProvider: ObservableObject {
    func present(_ modal: Modal)
    func fullScreenCoverDismissed()
}

class ModalCoordinator: @preconcurrency ModalCoordinatorProvider {
    @Published var currentSheet: Modal?
    @Published var currentFullScreenCover: Modal?

    private var sheetStack: [Modal] = []
    private var fullScreenCoverStack: [Modal] = []

    @MainActor
    func present(_ modal: Modal) {
        if modal.style == .sheet {
            sheetStack.append(modal)
            sheetStack.sort { $0.priority.rawValue > $1.priority.rawValue }

            if sheetStack.count == 1 {
                currentSheet = modal
            }

            // If no fullScreenCover is present, we insert a transparent view
            // to present the sheet on top
            if currentFullScreenCover == nil {
                var transaction = Transaction(animation: .none)
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    present(.emptyFullScreenCover)
                }
            }

        } else {
            fullScreenCoverStack.append(modal)
            fullScreenCoverStack.sort { $0.priority.rawValue > $1.priority.rawValue }

            if fullScreenCoverStack.count == 1 {
                currentFullScreenCover = modal
            }
        }

        debugPrint("Presenting sheet: \(modal)")
        debugPrint("Sheet stack: \(sheetStack)")
        debugPrint("FullScreenCover stack: \(fullScreenCoverStack)")
    }

    @MainActor
    func sheetDismissed() {
        guard !sheetStack.isEmpty else { return }

        sheetStack.removeFirst()

        if let nextSheet = sheetStack.first {
            currentSheet = nextSheet

        } else {
            currentSheet = nil

            // If the current fullScreenCover was only supporting the current sheet, we dismiss it as well
            if currentFullScreenCover == .emptyFullScreenCover {
                var transaction = Transaction(animation: .none)
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    fullScreenCoverDismissed()
                }
            }
        }
        debugPrint("Sheet stack: \(sheetStack)")
    }

    @MainActor
    func fullScreenCoverDismissed() {
        guard !fullScreenCoverStack.isEmpty else { return }

        fullScreenCoverStack.removeFirst()

        if let nextSheet = fullScreenCoverStack.first {
            currentFullScreenCover = nextSheet

        } else {
            currentFullScreenCover = nil
        }
        debugPrint("FullScreenCover stack: \(fullScreenCoverStack)")
    }
}
