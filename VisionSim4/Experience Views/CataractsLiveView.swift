import SwiftUI

/// Live cataract overlay that applies progressive blur, yellowing, haze,
/// and highlight diffusion directly onto the user’s real-world view.
struct CataractsLiveView: View {
    @State private var intensity: CGFloat = 0.0   // 0 = clear, 1 = severe

    // Effect tuning parameters
    private let maxDesat: CGFloat       = 0.55   // color desaturation
    private let darken: CGFloat         = 0.10   // contrast/brightness drop
    private let yellowing: CGFloat      = 0.35   // lens “brunescence” tint
    private let bloomStrength: CGFloat  = 0.12   // highlight diffusion
    private let hazeStrength: CGFloat   = 0.16   // animated patchy haze

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.clear.ignoresSafeArea()

                // 1) Desaturate
                Rectangle()
                    .fill(.gray)
                    .opacity(intensity * maxDesat)
                    .blendMode(.saturation)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)

                // 2) Slight darkening
                Rectangle()
                    .fill(.black)
                    .opacity(intensity * darken)
                    .blendMode(.multiply)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)

                // 3) Yellow tint overlay
                Rectangle()
                    .fill(Color(red: 1.0, green: 0.94, blue: 0.70))
                    .opacity(intensity * yellowing)
                    .blendMode(.color)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)

                // 4) Bloom / highlight diffusion
                Canvas { ctx, size in
                    guard intensity > 0 else { return }
                    let rBase: CGFloat = 180 + 240 * intensity
                    let blur: CGFloat  = 18 + 40 * intensity
                    let alpha: CGFloat = bloomStrength * intensity

                    ctx.addFilter(.blur(radius: blur))
                    ctx.blendMode = .overlay

                    // Four large lobes for forward scatter effect
                    let centers = [
                        CGPoint(x: size.width * 0.25, y: size.height * 0.30),
                        CGPoint(x: size.width * 0.72, y: size.height * 0.28),
                        CGPoint(x: size.width * 0.44, y: size.height * 0.72),
                        CGPoint(x: size.width * 0.80, y: size.height * 0.62)
                    ]
                    for c in centers {
                        let rect = CGRect(x: c.x - rBase, y: c.y - rBase,
                                          width: rBase * 2, height: rBase * 2)
                        ctx.fill(Path(ellipseIn: rect), with: .color(.white.opacity(alpha)))
                    }
                }
                .ignoresSafeArea()
                .allowsHitTesting(false)

                // 5) Animated noise-based haze layer
                TimelineView(.animation) { timeline in
                    CataractNoiseLayer(
                        intensity: intensity,
                        time: timeline.date.timeIntervalSinceReferenceDate,
                        strength: hazeStrength
                    )
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
                }

                // 6) Subtle peripheral haze
                RadialGradient(
                    gradient: Gradient(stops: [
                        .init(color: .clear,                           location: 0.0),
                        .init(color: .black.opacity(0.05 * intensity), location: 0.75),
                        .init(color: .black.opacity(0.10 * intensity), location: 1.00),
                    ]),
                    center: .center,
                    startRadius: 0,
                    endRadius: max(geo.size.width, geo.size.height)
                )
                .blendMode(.multiply)
                .ignoresSafeArea()
                .allowsHitTesting(false)

                // --- UI controls ---
                VStack {
                    Spacer()
                    Slider(value: $intensity, in: 0...1) {
                        Text("Cataract Severity")
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .frame(maxWidth: 420)

                    Text("Vision distortion: \(Int(intensity * 100))%")
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                        .padding(.bottom, 8)
                }
                .padding(.bottom, 80)
            }
        }
    }
}

/// Noise-based haze mask drawn in a Canvas.
/// Provides the drifting cloudy patterns for the cataract effect.
private struct CataractNoiseLayer: View {
    let intensity: CGFloat
    let time: TimeInterval
    let strength: CGFloat

    var body: some View {
        Canvas { ctx, size in
            guard intensity > 0 else { return }
            let alpha = strength * intensity

            ctx.addFilter(.blur(radius: 30 + 30 * intensity))
            ctx.blendMode = .screen   // lifts midtones subtly

            let w = size.width, h = size.height
            let t = CGFloat(time)

            // Four drifting blobs
            let k1 = CGPoint(x: w * (0.35 + 0.05 * sin(t * 0.17)),
                             y: h * (0.30 + 0.06 * cos(t * 0.21)))
            let k2 = CGPoint(x: w * (0.70 + 0.04 * cos(t * 0.14)),
                             y: h * (0.65 + 0.05 * sin(t * 0.19)))
            let k3 = CGPoint(x: w * (0.20 + 0.06 * sin(t * 0.11)),
                             y: h * (0.72 + 0.04 * cos(t * 0.16)))
            let k4 = CGPoint(x: w * (0.82 + 0.03 * cos(t * 0.23)),
                             y: h * (0.28 + 0.05 * sin(t * 0.13)))

            let r: CGFloat = max(w, h) * (0.22 + 0.28 * intensity)
            for c in [k1, k2, k3, k4] {
                let rect = CGRect(x: c.x - r, y: c.y - r, width: r * 2, height: r * 2)
                ctx.fill(Path(ellipseIn: rect), with: .color(.white.opacity(alpha)))
            }

            // Very subtle “starburst” lines at high severity
            if intensity > 0.6 {
                ctx.blendMode = .overlay
                let center = CGPoint(x: w * 0.5, y: h * 0.5)
                let spokes = 6
                let len: CGFloat = max(w, h)
                for i in 0..<spokes {
                    let a = CGFloat(i) * .pi * 2 / CGFloat(spokes)
                    var path = Path()
                    path.move(to: center)
                    path.addLine(to: CGPoint(x: center.x + cos(a) * len,
                                             y: center.y + sin(a) * len))
                    ctx.stroke(path, with: .color(.white.opacity(0.02 * intensity)), lineWidth: 8)
                }
            }
        }
    }
}

