import SwiftUI

struct ContentView: View {
    @StateObject var coordinator = ModalCoordinator()

    var body: some View {
        VStack(spacing: 20) {
            Button("Add Multiple Sheets to Queue") {
                coordinator.present(.someModal)
                coordinator.present(.anotherModal)
            }
            Button("Full Cover") {
                coordinator.present(.someModal)
            }

            Button("Sheet Without Existing Full Cover") {
                coordinator.present(.sheetWithoutFullscreenCover)
            }
        }
        .modalCoordinator(coordinator)
        .padding()
    }
}

#Preview {
    ContentView()
}

extension View {
    @ViewBuilder
    func modalCoordinator(_ coordinator: ModalCoordinator) -> some View {
        modifier(ModalCoordinating(coordinator: coordinator))
    }
}
