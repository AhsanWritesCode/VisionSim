// Macular Degeneration Interactive View

import SwiftUI

struct MacularDegenerationInteractiveView: View {
    // drive how strong central blur is (0…80)
    @State private var blurAmount: CGFloat = 0
    
    // The name of the background image
    var imageName: String = "md_scene_park"

    var body: some View {
        ZStack {
            // Base image
            Image(imageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()


            // Blurred overlay masked to the center of the image
            Image(imageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: blurAmount)
                .mask(
                    RadialGradient(
                        gradient: Gradient(stops: [
                            .init(color: .white, location: 0.0),
                            .init(color: .white, location: 0.4),
                            .init(color: .clear, location: 1.0)
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 400
                    )
                )
                .allowsHitTesting(false)

            // UI elements
            VStack {
                Spacer()

                // Slider to control the intensity of the cataracts effect
                Slider(value: $blurAmount, in: 0...80) {
                    Text("Intensity")
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .frame(maxWidth: 400)
                .mask(
                    RadialGradient(
                        gradient: Gradient(stops: [
                            .init(color: .white, location: 0.0),
                            .init(color: .white, location: 0.4),
                            .init(color: .clear, location: 1.0)
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 400
                    )
                )
                
                // Text describing the current intensity of the effect
                let percent = Int((blurAmount / 80) * 100)
                Text("Central vision loss: \(percent)%")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .padding(.top, 8)
                    .padding(.bottom, 8)
            }
            .padding(.bottom, 75)
            
        }
    }
}



