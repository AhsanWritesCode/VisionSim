import SwiftUI

struct CataractsLiveView: View {
    @State private var intensity: CGFloat = 0.0   // 0 = clear, 1 = severe

    // Tuning knobs
    private let maxDesat: CGFloat   = 0.55  // how much color to remove at 100%
    private let darken: CGFloat     = 0.08  // gentle global darken (offsets perceived haze)
    private let bloomStrength: CGFloat = 0.10 // diffusion strength

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Let the real world show through
                Color.clear.ignoresSafeArea()

                // 1) Desaturate without whitening (maps to your Image.saturation(..))
                Rectangle()
                    .fill(Color.gray)
                    .opacity(intensity * maxDesat)
                    .blendMode(.saturation)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)

                // 2) Gentle contrast/brightness drop (maps to your Image.brightness(-x))
                // Use multiply with a very subtle black to lower overall brightness w/o adding white.
                Rectangle()
                    .fill(Color.black)
                    .opacity(intensity * darken)
                    .blendMode(.multiply)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)

                // 3) Diffusion "bloom" (no white wash): soft, low-opacity blobs using overlay.
                Canvas { ctx, size in
                    guard intensity > 0 else { return }

                    let rBase: CGFloat = 220 + 200 * intensity
                    let blur: CGFloat  = 25 + 35 * intensity
                    let alpha: CGFloat = bloomStrength * intensity

                    ctx.addFilter(.blur(radius: blur))
                    ctx.blendMode = .overlay   // overlay ≈ contrast-preserving diffusion

                    let centers: [CGPoint] = [
                        CGPoint(x: size.width * 0.28, y: size.height * 0.32),
                        CGPoint(x: size.width * 0.72, y: size.height * 0.30),
                        CGPoint(x: size.width * 0.42, y: size.height * 0.70),
                        CGPoint(x: size.width * 0.78, y: size.height * 0.64)
                    ]

                    for c in centers {
                        let rect = CGRect(x: c.x - rBase, y: c.y - rBase,
                                          width: rBase * 2, height: rBase * 2)
                        ctx.fill(Path(ellipseIn: rect), with: .color(.white.opacity(alpha)))
                    }
                }
                .ignoresSafeArea()
                .allowsHitTesting(false)

                // 4) Very light edge haze (keeps center readable, no white veil)
                RadialGradient(
                    gradient: Gradient(stops: [
                        .init(color: .clear,                          location: 0.0),
                        .init(color: .black.opacity(0.06 * intensity), location: 0.80),
                        .init(color: .black.opacity(0.10 * intensity), location: 1.00),
                    ]),
                    center: .center,
                    startRadius: 0,
                    endRadius: max(geo.size.width, geo.size.height)
                )
                .blendMode(.multiply)
                .ignoresSafeArea()
                .allowsHitTesting(false)

                // Controls
                VStack {
                    Spacer()
                    Slider(value: $intensity, in: 0...1) { Text("Cataract Severity") }
                        .padding()
                        .background(.ultraThinMaterial) // just for the control chrome
                        .cornerRadius(10)
                        .frame(maxWidth: 400)

                    Text("Vision distortion: \(Int(intensity * 100))%")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                        .padding(.top, 6)
                        .padding(.bottom, 8)
                }
                .padding(.bottom, 75)
            }
        }
    }
}
