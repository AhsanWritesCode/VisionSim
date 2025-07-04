import SwiftUI

struct DiabeticRetinopathyLiveView: View {
    @State private var floaterDensity: CGFloat = 0.5
    private let maxFloaters = 25

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

    private let floaters: [Floater] = (0..<40).map { _ in Floater() }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear.ignoresSafeArea() // Transparent for passthrough

                TimelineView(.animation) { context in
                    let time = context.date.timeIntervalSinceReferenceDate
                    let count = Int(floaterDensity * CGFloat(maxFloaters))

                    ForEach(0..<count, id: \.self) { i in
                        let floater = floaters[i]
                        let x = floater.baseX + floater.amplitudeX * CGFloat(sin(time * floater.speed + floater.phase))
                        let y = floater.baseY + floater.amplitudeY * CGFloat(cos(time * floater.speed + floater.phase))

                        Ellipse()
                            .fill(Color.black.opacity(1))
                            .frame(width: floater.size.width, height: floater.size.height)
                            .blur(radius: 6)
                            .rotationEffect(floater.angle)
                            .position(
                                x: x * geometry.size.width,
                                y: y * geometry.size.height
                            )
                    }
                }

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
