import SwiftUI

/// A reusable button that closes the current window
/// and ensures the main content window is visible.
struct BackToHomeButton: View {
    // Provides dismiss action for the current scene
    @Environment(\.dismiss) private var dismiss
    // Allows programmatically opening other windows
    @Environment(\.openWindow) private var openWindow
    // Shared app state (tracks which windows are open, selections, etc.)
    @EnvironmentObject var appState: AppState

    var body: some View {
        Button("Back") {
            // Close the current window
            dismiss()
            // If the main window isn’t already open, launch it
            if !appState.isMainWindowOpen {
                openWindow(id: "mainContent")
            }
        }
        // Limit width so the button stays compact and tidy
        .frame(maxWidth: 100)
    }
}
