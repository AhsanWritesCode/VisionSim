import SwiftUI
import RealityKit
import RealityKitContent

struct ModelView: View {
    var body: some View {
        RealityView { content in
            if let model = try? await Entity(named: "EyeModel", in: realityKitContentBundle) {
                // Scale down if the model is too big
                model.scale = [0.01, 0.01, 0.01]

                // Move model 50 cm in front of user
                model.position = [0, 0, -0.5]

                content.add(model)
            } else {
                print("⚠️ Failed to load EyeModel from realityKitContentBundle")
            }
        }
        .edgesIgnoringSafeArea(.all)
        .overlay(alignment: .topLeading) {
            Button("Close") {
                // Add dismiss logic
            }
            .padding()
        }
    }
}
