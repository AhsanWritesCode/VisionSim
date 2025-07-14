// ModelView.swift

import SwiftUI
import RealityKit
import RealityKitContent

struct ModelView: View {
    var body: some View {
        RealityView { content in
            if let model = try? await Entity(named: "EyeModel", in: realityKitContentBundle) {
                content.add(model)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .overlay(alignment: .topLeading) {
            Button("Close") {
                // handle close logic if needed
            }
            .padding()
        }
    }
}
