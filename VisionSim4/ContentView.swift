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
    let impairment: VisionImpairment
    @State private var showInfo = false
    @State private var showNormalView = false
    @State private var showImpairedView = false
    @State private var currentImageIndex = 0


    var normalImages: [String] {
        switch impairment {
        case .macularDegeneration:
            return ["md_scene_park", "md_scene_street", "md_scene_office"]
        case .glaucoma:
            return ["gl_scene_park", "gl_scene_street", "gl_scene_office"]
        case .cataracts:
            return ["cat_scene_park", "cat_scene_street", "cat_scene_office"]
        }
    }

    var impairedImages: [String] {
        switch impairment {
        case .macularDegeneration:
            return ["md_scene_park_impaired", "md_scene_street_impaired", "md_scene_office_impaired"]
        case .glaucoma:
            return ["gl_scene_park_impaired", "gl_scene_street_impaired", "gl_scene_office_impaired"]
        case .cataracts:
            return ["cat_scene_park_impaired", "cat_scene_street_impaired", "cat_scene_office_impaired"]
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                showInfo.toggle()
            }) {
                Text("Learn About \(impairment.rawValue)")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.thickMaterial) // changed from regularMaterial
                    .cornerRadius(12)
            }

            Button(action: {
                showNormalView.toggle()
                showImpairedView.toggle()
            }) {
                Text("See Comparison Images")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.thickMaterial) // changed from regularMaterial
                    .cornerRadius(12)
            }
            
            Button(action: {
//                showExperience.toggle()
            }) {
                Text("Experience \(impairment.rawValue)")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.thickMaterial) // changed from regularMaterial
                    .cornerRadius(12)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(impairment.rawValue)
        .sheet(isPresented: $showInfo) {
            InfoPanelView(impairment: impairment)
        }
        .sheet(isPresented: $showNormalView) {
            ComparisonPopupView(
                title: "Normal View",
                images: normalImages,
                onClose: {
                    showImpairedView = true
                }
            )
        }
        .sheet(isPresented: $showImpairedView) {
            ComparisonPopupView(
                title: "\(impairment.rawValue) View",
                images: impairedImages,
                onClose: nil
            )
        }
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

                    // Placeholder text; replace with real content
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
    ContentView()
    
}
