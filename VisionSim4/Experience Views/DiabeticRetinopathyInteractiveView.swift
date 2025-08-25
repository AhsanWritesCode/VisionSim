import SwiftUI

struct DiabeticRetinopathyInteractiveView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var floaterDensity: CGFloat = 0.0
    let imageName: String

    // Match max behavior with your Live view (adjust as you like)
    private let maxFloaters = 25

    // Same motion model as Live view so behavior feels consistent
    struct Floater {
        let baseX: CGFloat = .random(in: 0.1...0.9)
        let baseY: CGFloat = .random(in: 0.1...0.9)
        let amplitudeX: CGFloat = .random(in: 0.02...0.08)
        let amplitudeY: CGFloat = .random(in: 0.02...0.08)
        let speed: Double = .random(in: 0.5...1.5)
        let size: CGSize = CGSize(width: .random(in: 60...100), height: .random(in: 20...40))
        let angle: Angle = .degrees(Double.random(in: 0..<360))
        let phase: Double = .random(in: 0..<2 * .pi)
    }

    // Pre-generate a pool so floaters are stable across frames
    private let floaters: [Floater] = (0..<40).map { _ in Floater() }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background image stays fixed (preset)
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .ignoresSafeArea()

                // Moving floaters over the image (same motion as Live)
                TimelineView(.animation) { context in
                    let time = context.date.timeIntervalSinceReferenceDate
                    let count = Int(floaterDensity * CGFloat(maxFloaters))

                    ForEach(0..<count, id: \.self) { i in
                        let f = floaters[i]
                        let x = f.baseX + f.amplitudeX * CGFloat(sin(time * f.speed + f.phase))
                        let y = f.baseY + f.amplitudeY * CGFloat(cos(time * f.speed + f.phase))

                        Ellipse()
                            .fill(Color.black) // fully opaque; tweak if you want translucency
                            .frame(width: f.size.width, height: f.size.height)
                            .blur(radius: 6)
                            .rotationEffect(f.angle)
                            .position(
                                x: x * geometry.size.width,
                                y: y * geometry.size.height
                            )
                            .allowsHitTesting(false)
                    }
                }

                // UI: slider + label
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

                // Back button pinned to safe area
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
