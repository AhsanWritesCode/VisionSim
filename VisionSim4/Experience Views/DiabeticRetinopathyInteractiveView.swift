import SwiftUI

/// Preset-image version of the DR simulator with animated “floaters”.
/// Matches the motion model used in the Live overlay so it feels consistent.
struct DiabeticRetinopathyInteractiveView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var floaterDensity: CGFloat = 0.0
    let imageName: String

    // Upper bound for how many floaters we’ll draw
    private let maxFloaters = 25

    // Same motion parameters as the Live view
    struct Floater {
        let baseX: CGFloat = .random(in: 0.1...0.9)     // center position (unit coords)
        let baseY: CGFloat = .random(in: 0.1...0.9)
        let amplitudeX: CGFloat = .random(in: 0.02...0.08) // horizontal drift
        let amplitudeY: CGFloat = .random(in: 0.02...0.08) // vertical drift
        let speed: Double = .random(in: 0.5...1.5)      // motion speed multiplier
        let size: CGSize = CGSize(width: .random(in: 60...100), height: .random(in: 20...40))
        let angle: Angle = .degrees(Double.random(in: 0..<360))
        let phase: Double = .random(in: 0..<2 * .pi)   // offsets each floater’s sine/cosine
    }

    // Fixed pool so floaters don’t “jump” when density changes
    private let floaters: [Floater] = (0..<40).map { _ in Floater() }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background photo (this is the “preset” part)
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .ignoresSafeArea()

                // Animated floaters drawn over the photo
                TimelineView(.animation) { context in
                    let time = context.date.timeIntervalSinceReferenceDate
                    let count = Int(floaterDensity * CGFloat(maxFloaters))

                    ForEach(0..<count, id: \.self) { i in
                        let f = floaters[i]
                        // Unit-space position with gentle sinusoidal drift
                        let x = f.baseX + f.amplitudeX * CGFloat(sin(time * f.speed + f.phase))
                        let y = f.baseY + f.amplitudeY * CGFloat(cos(time * f.speed + f.phase))

                        Ellipse()
                            .fill(Color.black)          // use opacity here if you want see-through floaters
                            .frame(width: f.size.width, height: f.size.height)
                            .blur(radius: 6)             // softer edges
                            .rotationEffect(f.angle)
                            .position(
                                x: x * geometry.size.width,
                                y: y * geometry.size.height
                            )
                            .allowsHitTesting(false)      // gestures pass through
                    }
                }

                // Slider + readout
                VStack {
                    Spacer()

                    Slider(value: $floaterDensity, in: 0...1) {
                        Text("Floaters")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .frame(maxWidth: 420)

                    Text("Floaters: \(Int(floaterDensity * 100))%")
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                        .foregroundColor(.primary)
                }
                .padding(.bottom, 30)

                // Back button pinned to the safe area at the top-left
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
