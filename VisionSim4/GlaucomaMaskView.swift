//
//  GlaucomaMaskView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-27.
//

import SwiftUI

struct GlaucomaMaskView: View {
    let imageName: String
    @Binding var blurRadius: CGFloat  // or blackout intensity

    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFit()

            // Black circular overlay that shrinks based on blurRadius
            RadialGradient(
                gradient: Gradient(colors: [.black, .clear]),
                center: .center,
                startRadius: blurRadius,
                endRadius: 500
            )
            .blendMode(.multiply)
            .allowsHitTesting(false)
        }
        .clipped()
    }
}
