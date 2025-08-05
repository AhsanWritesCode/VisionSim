import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            NavigationView {
                List(VisionImpairment.allCases) { impairment in
                    NavigationLink(destination: ImpairmentDetailView(impairment: impairment)) {
                        Text(impairment.rawValue)
                    }
                }
                .navigationTitle("Select Impairment")
            }
            .onAppear {
                appState.isMainWindowOpen = true
            }
            .onDisappear {
                appState.isMainWindowOpen = false
            }
//
//            // 👁️ Add EyeModel to scene if requested
//            RealityView { content in
//                if appState.shouldShowEyeModel {
//                    let eye = await EyeEntity(configuration: .normalEye)
//                    content.add(eye)
//                }
//            }
//            .allowsHitTesting(false) // Prevent UI interference
        }
    }
}
