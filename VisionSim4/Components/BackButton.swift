import SwiftUI

struct BackToHomeButton: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openWindow) private var openWindow
    @EnvironmentObject var appState: AppState

    var body: some View {
        Button {
            dismiss()
            if !appState.isMainWindowOpen {
                openWindow(id: "mainContent")
            }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .font(.headline)
            .foregroundColor(.blue)
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
        }
    }
}
