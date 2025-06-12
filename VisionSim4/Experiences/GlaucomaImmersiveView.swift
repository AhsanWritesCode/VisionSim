//
//  GlaucomaImmersiveView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-29.
//

// Not working


//import SwiftUI
//import RealityKit
//import RealityKitContent
//
//struct GlaucomaImmersiveView: View {
//    @Environment(\.dismissImmersiveSpace) var dismiss
//
//    var body: some View {
//        ZStack {
//            // Optional background (e.g., real-world camera or placeholder)
//            RealityView { _ in }
//
//            // Black vignette mask with clear center
//            Color.black
//                .mask(
//                    RadialGradient(
//                        gradient: Gradient(stops: [
//                            .init(color: .clear, location: 0.0),
//                            .init(color: .clear, location: 0.3), // center stays clear
//                            .init(color: .black, location: 1.0)  // black edges
//                        ]),
//                        center: .center,
//                        startRadius: 0,
//                        endRadius: 800
//                    )
//                )
//                .blendMode(.multiply)
//                .ignoresSafeArea()
//
//            // Exit Button
//            VStack {
//                Spacer()
//                Button("Exit") {
//                    Task {
//                        await dismiss()
//                    }
//                }
//                .padding()
//            }
//        }
//    }
//}
