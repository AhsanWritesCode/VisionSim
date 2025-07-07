import SwiftUI
import RealityKit
import RealityKitContent

// Enumeration of vision impairments
enum VisionImpairment: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    case macularDegeneration = "Macular Degeneration"
    case glaucoma = "Glaucoma"
    case cataracts = "Cataracts"
    case diabeticRetinopathy = "Diabetic Retinopathy"
}

// Main content view with navigation
struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
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
    }
}
