import SwiftUI

struct BackToHomeButton: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openWindow) private var openWindow
    @EnvironmentObject var appState: AppState

    var body: some View {
        Button("Back") {
            dismiss()
            if !appState.isMainWindowOpen {
                openWindow(id: "mainContent")
            }
        }
        .frame(maxWidth: 100) // to match Exit sizing
    }
}
