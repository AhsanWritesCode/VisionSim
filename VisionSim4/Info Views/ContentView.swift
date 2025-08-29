import SwiftUI
import RealityKit
import RealityKitContent

/// Main list view that lets the user choose which vision impairment
/// they want to explore. Tracks whether the main window is open
/// so other views can bring it back if closed.
struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            NavigationView {
                // List all available impairments with navigation links
                List(VisionImpairment.allCases) { impairment in
                    NavigationLink(destination: ImpairmentDetailView(impairment: impairment)) {
                        Text(impairment.rawValue)
                    }
                }
                .navigationTitle("Select Impairment")
            }
            // Track the state of this window so the app knows if
            // the main content is currently open or not
            .onAppear {
                appState.isMainWindowOpen = true
            }
            .onDisappear {
                appState.isMainWindowOpen = false
            }
        }
    }
}
