import SwiftUI

/// Interactive preset view for simulating macular degeneration.
/// Uses a blurred duplicate of the background image masked to the center
/// to mimic progressive central vision loss.
struct MacularDegenerationInteractiveView: View {
    // Amount of blur in the center (0 = clear, 80 = fully blurred)
    @State private var blurAmount: CGFloat = 0
    
    // Background photo name (e.g. park, street, office)
    var imageName: String = "md_scene_park"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Base background image
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // Blurred duplicate, masked to the center of the image
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
                
                // --- Controls ---
                VStack {
                    Spacer()
                    
                    // Slider controls blur intensity
                    Slider(value: $blurAmount, in: 0...80) {
                        Text("Intensity")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                    .frame(maxWidth: 400)
                    // Optional mask to emphasize central interaction area
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
                    
                    // Label showing current percentage of effect
                    let percent = Int((blurAmount / 80) * 100)
                    Text("Central vision loss: \(percent)%")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                        .padding(.vertical, 8)
                }
                .padding(.bottom, 100)
                
                // Back button pinned to top-left corner
                VStack {
                    HStack {
                        BackToHomeButton()
                            .padding(.top, geometry.safeAreaInsets.top + 12)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    Spacer()
                }
                .ignoresSafeArea(.all, edges: .top)
            }
        }
    }
}
