import SwiftUI

struct ImmersiveGlaucomaView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var intensity: CGFloat = 0.0   // 0 = no blackout, 1 = full blackout
    let imageName: String                         // e.g. "gl_scene_park"

    var body: some View {
        ZStack {
            // -------------------------------------------------------
            // 1) BACKGROUND: full-screen image (or RealityView)
            // -------------------------------------------------------
            Image(imageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // -------------------------------------------------------
            // 2) SOFT-EDGED MASK: radial gradient with a fade zone
            // -------------------------------------------------------
            GeometryReader { geo in
                // Compute maximum radius (half the diagonal)
                let maxRadius = hypot(geo.size.width, geo.size.height) / 2

                // Determine how large the clear circle should be:
                //   - At intensity=0 → clearRadius = maxRadius  (no blackout)
                //   - At intensity=1 → clearRadius = 0          (fully black)
                let clearRadius = maxRadius * (1.0 - intensity)

                // Pick how “thick” the blur band should be (in points).
                // e.g. 60 points of radius used to fade from clear→solid black.
                let blurWidth: CGFloat = 60

                // Convert absolute radii → normalized (0…1) for the gradient's "stops"
                let clearFrac   = (clearRadius / maxRadius)
                let blurFracEnd = ((clearRadius + blurWidth) / maxRadius)

                // Clamp both to [0…1]
                let cFrac = min(max(clearFrac, 0), 1)
                let bFrac = min(max(blurFracEnd, 0), 1)

                // Build a radial gradient that is:
                //   0…cFrac   → fully clear
                //   cFrac…bFrac → transition      (clear→black)
                //   bFrac…1.0  → fully black
                let gradient = RadialGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.clear, location: 0.0),
                        .init(color: Color.clear, location: cFrac),
                        .init(color: Color.black, location: bFrac),
                        .init(color: Color.black, location: 1.0)
                    ]),
                    center: .center,
                    startRadius: 0,
                    endRadius: maxRadius
                )

                gradient
                    .ignoresSafeArea()
                    .blendMode(.multiply)
            }

            // -------------------------------------------------------
            // 3) UI CONTROLS: slider + exit at the bottom
            // -------------------------------------------------------
            VStack {
                Spacer()

                // Slider to control tunnel intensity (0…1)
                Slider(value: $intensity, in: 0...1) {
                    Text("Peripheral Vision Loss")
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .frame(maxWidth: 400)

                // Text feedback
                Text("Peripheral vision loss: \(Int(intensity * 100))%")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .padding(.top, 8)
                    .padding(.bottom, 8)

//                Button("Exit") {
//                    dismiss()
//                }
//                .padding(.top, 8)
            }
            .padding(.bottom, 75)
        }
    }
}

#if DEBUG
struct ImmersiveGlaucomaView_Previews: PreviewProvider {
    static var previews: some View {
        ImmersiveGlaucomaView(imageName: "gl_scene_park")
    }
}
#endif
