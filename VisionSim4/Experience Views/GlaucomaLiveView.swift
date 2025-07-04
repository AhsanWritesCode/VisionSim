import SwiftUI

struct GlaucomaLiveView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var intensity: CGFloat = 0.0   // 0 = no blackout, 1 = full blackout

    var body: some View {
        ZStack {
            // Transparent background (lets environment show through)
            Color.clear
                .ignoresSafeArea()

            // Vignette effect (simulated peripheral vision loss)
            GeometryReader { geo in
                let maxRadius = hypot(geo.size.width, geo.size.height) / 2
                let clearRadius = maxRadius * (1.0 - intensity)
                let blurWidth: CGFloat = 60

                let clearFrac = (clearRadius / maxRadius)
                let blurFracEnd = ((clearRadius + blurWidth) / maxRadius)

                let cFrac = min(max(clearFrac, 0), 1)
                let bFrac = min(max(blurFracEnd, 0), 1)

                RadialGradient(
                    gradient: Gradient(stops: [
                        .init(color: .clear, location: 0.0),
                        .init(color: .clear, location: cFrac),
                        .init(color: .black, location: bFrac),
                        .init(color: .black, location: 1.0)
                    ]),
                    center: .center,
                    startRadius: 0,
                    endRadius: maxRadius
                )
                .ignoresSafeArea()
                .blendMode(.multiply)
            }

            // UI Controls
            VStack {
                Spacer()

                Slider(value: $intensity, in: 0...1) {
                    Text("Peripheral Vision Loss")
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(8)
                .frame(maxWidth: 400)

                Text("Peripheral vision loss: \(Int(intensity * 100))%")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
                    .padding(.top, 8)
                    .padding(.bottom, 8)
            }
            .padding(.bottom, 75)
        }
    }
}
