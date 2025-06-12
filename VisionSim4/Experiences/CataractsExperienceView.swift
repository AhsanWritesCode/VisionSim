//
//  CataractsExperienceView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-28.
//

import SwiftUI

struct ImmersiveCataractsView: View {
    @Environment(\.dismiss) private var dismiss

    /// 0.0 = perfect vision, 1.0 = maximum distortion (blur + desaturate + dim)
    @State private var intensity: CGFloat = 0.0

    /// The name of the image you want to display (e.g., "cat_scene_park").
    let imageName: String

    var body: some View {
        ZStack {
            // -------------------------------------------------------
            // 1) BACKGROUND: full‐screen image with cataracts effect
            // -------------------------------------------------------
            Image(imageName)
                .resizable()
                .scaledToFill()
                .saturation(1.0 - (intensity * 0.5))   // fade colors up to 50%
                .blur(radius: intensity * 10)          // blur up to 10px
                .brightness(-intensity * 0.1)          // slight dimming up to -0.1
                .ignoresSafeArea()

            // -------------------------------------------------------
            // 2) UI CONTROLS: slider + percentage + exit at bottom
            // -------------------------------------------------------
            VStack {
                Spacer()

                // 2a) Slider to control “intensity” of cataract effect
                Slider(value: $intensity, in: 0...1) {
                    Text("Intensity")
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .frame(maxWidth: 400)

                // 2b) Text feedback for percentage
                Text("Vision distortion: \(Int(intensity * 100))%")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .padding(.top, 8)
                    .padding(.bottom, 8)

//                Button("Exit") {
//                    dismiss()
//                }
//                .padding(.top, 8)
            }
            .padding(.bottom, 75)
        }
    }
}
