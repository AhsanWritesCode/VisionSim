// Cataracts Interactive View

import SwiftUI

struct CataractsInteractiveView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var intensity: CGFloat = 0.0
    let imageName: String

    var body: some View {
        ZStack {
            // Background with cataracts effect
            Image(imageName)
                .resizable()
                .scaledToFill()
                .saturation(1.0 - (intensity * 0.5))
                .blur(radius: intensity * 10)
                .brightness(-intensity * 0.1)
                .ignoresSafeArea()

            // UI controls
            VStack {
                Spacer()

                // Slider
                Slider(value: $intensity, in: 0...1) {
                    Text("Intensity")
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .frame(maxWidth: 400)

                // Intensity label
                Text("Vision distortion: \(Int(intensity * 100))%")
                    .font(.subheadline)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial) // Adds blurred background for contrast
                    .cornerRadius(10)
                    .foregroundColor(.primary) // Adapts to light/dark modes

                // Back button
                BackToHomeButton()
                    .padding(.top, 4)
            }
            .padding(.bottom, 75)
        }
    }
}
