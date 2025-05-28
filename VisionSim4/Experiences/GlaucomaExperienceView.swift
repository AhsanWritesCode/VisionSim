//
//  GlaucomaExperienceView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-28.
//

import SwiftUI

struct GlaucomaExperienceView: View {
    @State private var intensity: CGFloat = 0.0  // 0 = full vision, 1 = total tunnel vision
    let imageName: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Glaucoma Simulation")
                .font(.title)

            GlaucomaMaskView(imageName: imageName, intensity: $intensity)
                .frame(height: 400)
                .cornerRadius(12)
                .padding()

            Slider(value: $intensity, in: 0...1) {
                Text("Peripheral Vision Loss")
            }
            .padding()

            Text("Peripheral vision loss: \(Int(intensity * 100))%")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Spacer()
        }
        .padding()
    }
}
