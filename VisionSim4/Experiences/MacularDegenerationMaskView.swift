//
//  GlaucomaMaskView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-27.
//

import SwiftUI

struct MacularDegenerationMaskView: View {
    let imageName: String
    @Binding var blurRadius: CGFloat

    var body: some View {
        ZStack {
            // Base image
            Image(imageName)
                .resizable()
                .scaledToFit()

            // Blurred version of the image, masked to center
            Image(imageName)
                .resizable()
                .scaledToFit()
                .blur(radius: blurRadius)
                .mask(
                    RadialGradient(
                        gradient: Gradient(colors: [.black, .clear]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 300
                    )
                )
                .allowsHitTesting(false)
        }
        .clipped()
    }
}
