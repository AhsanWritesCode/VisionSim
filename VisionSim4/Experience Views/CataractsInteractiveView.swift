// Cataracts Interactive View

import SwiftUI

struct CataractsInteractiveView: View {
    @Environment(\.dismiss) private var dismiss

    // 0.0 = Perfect vision
    // 1.0 = Maximum distortion
    @State private var intensity: CGFloat = 0.0

    let imageName: String // Name of the image shown in the effect

    var body: some View {
        ZStack {
            // Cataracts effects
            Image(imageName)
                .resizable()
                .scaledToFill()
                .saturation(1.0 - (intensity * 0.5))   // Fade colors up to 50%
                .blur(radius: intensity * 10)          // Blur up to 10px
                .brightness(-intensity * 0.1)          // Slight dimming up to -0.1
                .ignoresSafeArea()

            // UI elements
            VStack {
                Spacer()

                // Slider to control the intensity of the cataracts effect
                Slider(value: $intensity, in: 0...1) {
                    Text("Intensity")
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .frame(maxWidth: 400)

                // Text describing the current intensity of the effect
                Text("Vision distortion: \(Int(intensity * 100))%")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .padding(.top, 8)
                    .padding(.bottom, 8)

                // "Exit" button to leave the view
//                Button("Exit") {
//                    dismiss()
//                }
//                .padding(.top, 8)
            }
            .padding(.bottom, 75)
        }
    }
}
