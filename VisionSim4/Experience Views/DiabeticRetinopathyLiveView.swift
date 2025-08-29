import SwiftUI

/// Live, environment-overlaid version of the DR effect.
/// Renders animated “floaters” on a transparent canvas over the user’s view.
struct DiabeticRetinopathyLiveView: View {
    @State private var floaterDensity: CGFloat = 0.5   // 0–1 slider control
    private let maxFloaters = 25                       // cap the draw count

    // Same motion profile as the interactive preset view so behavior matches
    struct Floater {
        let baseX: CGFloat = .random(in: 0.1...0.9)       // center (unit space)
        let baseY: CGFloat = .random(in: 0.1...0.9)
        let amplitudeX: CGFloat = .random(in: 0.02...0.08) // gentle horizontal drift
        let amplitudeY: CGFloat = .random(in: 0.02...0.08) // gentle vertical drift
        let speed: Double = .random(in: 0.5...1.5)         // per-floater speed
        let size: CGSize = CGSize(width: .random(in: 60...100), height: .random(in: 20...40))
        let angle: Angle = .degrees(Double.random(in: 0..<360))
        let phase: Double = .random(in: 0..<2 * .pi)       // de-phase each path
    }

    // Pre-generate so the set is stable as density changes
    private let floaters: [Floater] = (0..<40).map { _ in Floater() }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Keep the background clear so this can overlay real-world content
                Color.clear.ignoresSafeArea()

                // Animate positions with TimelineView to stay efficient and smooth
                TimelineView(.animation) { context in
                    let time = context.date.timeIntervalSinceReferenceDate
                    let count = Int(floaterDensity * CGFloat(maxFloaters))

                    ForEach(0..<count, id: \.self) { i in
                        let f = floaters[i]
                        // Sine/cosine drift around each floater’s base position
                        let x = f.baseX + f.amplitudeX * CGFloat(sin(time * f.speed + f.phase))
                        let y = f.baseY + f.amplitudeY * CGFloat(cos(time * f.speed + f.phase))

                        Ellipse()
                            .fill(Color.black.opacity(1)) // make partially transparent if preferred
                            .frame(width: f.size.width, height: f.size.height)
                            .blur(radius: 6)
                            .rotationEffect(f.angle)
                            .position(x: x * geometry.size.width,
                                      y: y * geometry.size.height)
                    }
                }

                // Simple in-place control + readout
                VStack {
                    Spacer()

                    Slider(value: $floaterDensity, in: 0...1) {
                        Text("Floaters")
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .frame(maxWidth: 400)

                    Text("Floaters: \(Int(floaterDensity * 100))%")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                }
                .padding(.bottom, 75)
            }
        }
    }
}
