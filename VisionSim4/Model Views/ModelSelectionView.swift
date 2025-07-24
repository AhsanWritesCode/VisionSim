import SwiftUI

struct ModelSelectionView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.openWindow) var openWindow

    var body: some View {
        VStack(spacing: 20) {
            Text("Select Eye Model")
                .font(.title2)

            Button("Normal Eye") {
                appState.selectedEyeModelName = "EyeModel" // maps to EyeModel.usdz
            }
            .buttonStyle(.borderedProminent)

            Button("Load Model") {
                openWindow(id: "modelView")
                
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}
