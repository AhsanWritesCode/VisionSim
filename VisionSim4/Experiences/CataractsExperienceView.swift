//
//  CataractsExperienceView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-28.
//

import SwiftUI

struct CataractsExperienceView: View {
    @State private var intensity: CGFloat = 0.0
    let imageName: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Cataracts Simulation")
                .font(.title)

            CataractsMaskView(imageName: imageName, intensity: intensity)
                .frame(height: 400)
                .cornerRadius(12)
                .padding()

            Slider(value: $intensity, in: 0...1) {
                Text("Intensity")
            }
            .padding()

            Text("Vision distortion: \(Int(intensity * 100))%")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Spacer()
        }
        .padding()
    }
}
