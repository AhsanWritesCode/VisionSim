////
////  MacularDegenerationMaskView.swift
////  VisionSim4
////
////  Created by Ahsan Tariq on 2025-05-27.
////
//
//import SwiftUI
//
//struct MacularDegenerationMaskView: View {
//    let imageName: String
//    @Binding var blurRadius: CGFloat
//
//    var body: some View {
//        ZStack {
//            // Original image
//            Image(imageName)
//                .resizable()
//                .scaledToFit()
//
//            // Blurred version masked from center outward
//            Image(imageName)
//                .resizable()
//                .scaledToFit()
//                .blur(radius: blurRadius / 5) // adjust strength
//                .mask(
//                    RadialGradient(
//                        gradient: Gradient(colors: [.black, .black, .black.opacity(0.9), .black.opacity(0.3), .clear]),
//                        center: .center,
//                        startRadius: 0,
//                        endRadius: blurRadius * 3
//                    )
//                )
//        }
//        .clipped()
//    }
//}
