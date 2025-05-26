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

    var body: some View {
        VStack(spacing: 20) {
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

            Button(action: {
                showNormalView.toggle()
                showImpairedView.toggle()
            }) {
                Text("See Comparison")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(8)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(impairment.rawValue)
        .sheet(isPresented: $showInfo) {
            InfoPanelView(impairment: impairment)
        }
        .sheet(isPresented: $showNormalView) {
            ComparisonPopupView(title: "Normal View", imageName: "normal_example")
        }
        .sheet(isPresented: $showImpairedView) {
            ComparisonPopupView(title: "\(impairment.rawValue) View", imageName: "impaired_example")
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
