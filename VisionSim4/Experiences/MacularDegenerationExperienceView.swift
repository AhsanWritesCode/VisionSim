//
//  MacularDegenerationExperienceView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-27.
//

import SwiftUI

struct MacularDegenerationExperienceView: View {
    @State private var intensity: CGFloat = 0.0
    let imageName: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Macular Degeneration Simulation")
                .font(.title)


            MacularDegenerationMaskView(imageName: imageName, blurRadius: $intensity)
                .frame(height: 400)
                .cornerRadius(12)
                .padding()


            Slider(value: $intensity, in: 0...250) {
                Text("Intensity")
            }
            .padding()

            Text("Central vision loss: \(Int(intensity / 2.5))%")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Spacer()
        }
        .padding()
    }
}
