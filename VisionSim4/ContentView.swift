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

    var body: some View {
        VStack(spacing: 20) {
            // Placeholder for RealityKit or simulation content
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 30)
                .frame(maxHeight: 300)

            Button(action: {
                showInfo.toggle()
            }) {
                Text("Learn About \(impairment.rawValue)")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }
            Spacer()
        }
        .padding()
        .navigationTitle(impairment.rawValue)
        .sheet(isPresented: $showInfo) {
            InfoPanelView(impairment: impairment)
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
