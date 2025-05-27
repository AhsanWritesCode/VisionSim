import SwiftUI
import RealityKit
import RealityKitContent

// Enumeration of vision impairments
enum VisionImpairment: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    case macularDegeneration = "Macular Degeneration"
    case glaucoma = "Glaucoma"
    case cataracts = "Cataracts"
}


// Main content view with navigation
struct ContentView: View {
    var body: some View {
        NavigationView {
            List(VisionImpairment.allCases) { impairment in
                NavigationLink(destination: ImpairmentDetailView(impairment: impairment)) {
                    Text(impairment.rawValue)
                }
            }
            .navigationTitle("Select Impairment")
        }
    }
}






#Preview {
    ContentView().environmentObject(AppState())
}
