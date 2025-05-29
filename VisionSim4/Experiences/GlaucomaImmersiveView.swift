//
//  GlaucomaImmersiveView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-29.
//

// Not working


import SwiftUI
import RealityKit
import RealityKitContent

struct GlaucomaImmersiveView: View {
    @Environment(\.dismissImmersiveSpace) var dismiss
    @State private var intensity: CGFloat = 0.5

    var body: some View {
        ZStack {
            // Clear center, black vignette peripheral mask
            Color.black
                .mask(
                    RadialGradient(
                        gradient: Gradient(stops: [
                            .init(color: .clear, location: 0.5),

                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 600
                    )
                )
                .blendMode(.multiply)
                .ignoresSafeArea()



            VStack {
                Slider(value: $intensity, in: 0...1)
                    .padding()

                Button("Exit") {
                    Task {
                        await dismiss()
                    }
                }
                .padding()
            }
        }
    }
}
