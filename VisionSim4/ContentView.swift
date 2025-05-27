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

// Detail view showing information panel
struct ImpairmentDetailView: View {
    @Environment(\.openWindow) private var openWindow
    @EnvironmentObject var appState: AppState

    let impairment: VisionImpairment

    var normalImages: [String] {
        switch impairment {
        case .macularDegeneration: return ["md_scene_park", "md_scene_street", "md_scene_office"]
        case .glaucoma: return ["gl_scene_park", "gl_scene_street", "gl_scene_office"]
        case .cataracts: return ["cat_scene_park", "cat_scene_street", "cat_scene_office"]
        }
    }

    var impairedImages: [String] {
        switch impairment {
        case .macularDegeneration: return ["md_scene_park_impaired", "md_scene_street_impaired", "md_scene_office_impaired"]
        case .glaucoma: return ["gl_scene_park_impaired", "gl_scene_street_impaired", "gl_scene_office_impaired"]
        case .cataracts: return ["cat_scene_park_impaired", "cat_scene_street_impaired", "cat_scene_office_impaired"]
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Button("See Normal View") {
                appState.selectedImpairment = impairment
                openWindow(id: "normalView")
            }
            .buttonStyle(CustomButtonStyle())

            Button("See Impaired View") {
                appState.selectedImpairment = impairment
                openWindow(id: "impairedView")
            }
            .buttonStyle(CustomButtonStyle())

            if impairment == .macularDegeneration {
                Button("Experience Macular Degeneration") {
                    openWindow(id: "macularDegenerationExperience")
                }
                .buttonStyle(CustomButtonStyle())
            }

            Spacer()
        }
        .padding()
        .navigationTitle(impairment.rawValue)
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(white: 0.2))
            .cornerRadius(12)
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
    }
}

// Information panel view
struct InfoPanelView: View {
    let impairment: VisionImpairment
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text(impairment.rawValue)
                        .font(.title)
                        .bold()

                    Text("Detailed information about \(impairment.rawValue) goes here. You can describe symptoms, causes, and how the simulation approximates the effect.")
                        .font(.body)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("About")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(AppState())
}
