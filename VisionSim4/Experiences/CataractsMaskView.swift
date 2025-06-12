//    //
//    //  CataractsMaskView.swift
//    //  VisionSim4
//    //
//    //  Created by Ahsan Tariq on 2025-05-28.
//    //
//
//    import SwiftUI
//
//    struct CataractsMaskView: View {
//        let imageName: String
//        var intensity: CGFloat // 0.0 to 1.0
//
//        var body: some View {
//            ZStack {
//                Image(imageName)
//                    .resizable()
//                    .scaledToFit()
//                    .saturation(CGFloat(1.0) - (intensity * 0.5))
//                    .blur(radius: intensity * 10)      // full blur range
//                    .brightness(-intensity * 0.1)      // optional: slight dimming
//            }
//        }
//    }
