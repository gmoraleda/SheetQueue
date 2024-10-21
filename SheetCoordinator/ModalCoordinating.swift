import SwiftUI

struct ModalCoordinating: ViewModifier {
    @StateObject var coordinator: ModalCoordinator

    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .fullScreenCover(
                item: $coordinator.currentFullScreenCover,
                onDismiss: {
                    coordinator.fullScreenCoverDismissed()
                },
                content: { sheet in
                    sheet
                        .view()
                        .sheet(
                            item: $coordinator.currentSheet,
                            onDismiss: {
                                coordinator.sheetDismissed()
                            },
                            content: { sheet in
                                sheet.view()
                            }
                        )
                }
            )
    }
}
