//
//  MacularDegenerationExperienceView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-27.
//

import SwiftUI


struct MacularDegenerationExperienceView: View {
    // drive how strong central blur is
    @State private var blurAmount: CGFloat = 0
    

    var imageName: String = "md_scene_park"

    // to dismiss the window
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // 1) Base image
            Image(imageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // 2) Blurred overlay masked to the center
            Image(imageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: blurAmount)
                .mask(
                    RadialGradient(
                        gradient: Gradient(stops: [
                            .init(color: .white, location: 0),
                            .init(color: .white, location: 0.4),
                            .init(color: .clear, location: 1)
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 400
                    )
                )
                .allowsHitTesting(false)

            // 3) Slider + Exit UI
            VStack {
                Spacer()
                Slider(value: $blurAmount, in: 0...80) {
                    Text("Intensity")
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .frame(maxWidth: 400)

                Button("Exit") {
                    dismiss()
                }
                .padding(.top, 8)
            }
            .padding(.bottom, 30)
        }
    }
}

#if DEBUG
struct MacularDegenerationExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        MacularDegenerationExperienceView()
    }
}
#endif
