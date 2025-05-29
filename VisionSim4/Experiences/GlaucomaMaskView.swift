//
//  GlaucomaMaskView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-28.
//

import SwiftUI

struct GlaucomaMaskView: View {
    let imageName: String
    @Binding var intensity: CGFloat  // from 0 (no loss) to 1 (full tunnel vision)

    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFit()

            // Dark peripheral mask
            RadialGradient(
                gradient: Gradient(colors: [.clear, .black]),
                center: .center,
                startRadius: 0,
                endRadius: 350 * (1 - intensity + 0.1)  // smaller endRadius = more tunnel vision
            )
            .blendMode(.multiply)
            .allowsHitTesting(false)
        }
        .clipped()
    }
}
