import SwiftUI

protocol ModalPresentable: Identifiable, Equatable {
    associatedtype Body: View

    var priority: Modal.Priority { get }
    var style: Modal.Style { get }

    @ViewBuilder
    func view() -> Body
}

enum Modal: Identifiable, @preconcurrency ModalPresentable {
    enum Priority {
        case high
        case low
        case custom(Int)

        var rawValue: Int {
            switch self {
            case .high:
                100
            case .low:
                0
            case .custom(let value):
                value
            }
        }

        init?(rawValue: Int) {
            switch rawValue {
            case 100:
                self = .high
            case 0:
                self = .low
            default:
                self = .custom(rawValue)
            }
        }
    }

    enum Style {
        case sheet, fullScreenCover
    }

    // MARK: Modal views

    case someModal
    case anotherModal
    case sheetWithoutFullscreenCover
    case emptyFullScreenCover

    var id: String {
        switch self {
        case .someModal:
            "someModal"
        case .anotherModal:
            "anotherModal"
        case .emptyFullScreenCover:
            "emptyFullScreenCover"
        case .sheetWithoutFullscreenCover:
            "sheetWithoutFullscreenCover"
        }
    }

    var priority: Priority {
        switch self {
        case .someModal:
            .high

        default:
            .low
        }
    }

    var style: Style {
        switch self {
        case .someModal, .emptyFullScreenCover:
            .fullScreenCover
        default:
            .sheet
        }
    }

    @ViewBuilder
    @MainActor
    func view() -> some View {
        switch self {
        case .someModal, .anotherModal, .sheetWithoutFullscreenCover:
            SomeModal()
        case .emptyFullScreenCover:
            BackgroundClearView()
        }
    }
}

extension Modal: Equatable {
    static func == (lhs: Modal, rhs: Modal) -> Bool {
        lhs.id == rhs.id
    }
}

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context _: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_: UIView, context _: Context) {}
}

struct SomeModal: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Some Modal")
            Button("Dismiss") {
                dismiss()
            }
        }
    }
}
