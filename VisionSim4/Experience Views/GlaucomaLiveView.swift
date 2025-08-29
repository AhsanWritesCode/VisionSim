import SwiftUI

/// Live glaucoma overlay that simulates peripheral vision loss
/// by applying a dark vignette directly over the user’s environment.
struct GlaucomaLiveView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var intensity: CGFloat = 0.0   // 0 = clear, 1 = full blackout
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Transparent base so the environment remains visible
                Color.clear
                    .ignoresSafeArea()
                
                // Radial gradient vignette that grows inward as intensity increases
                GeometryReader { geo in
                    let maxRadius = hypot(geo.size.width, geo.size.height) / 2
                    let clearRadius = maxRadius * (1.0 - intensity) // fully visible center
                    let blurWidth: CGFloat = 60                    // soft transition edge
                    
                    let clearFrac = clearRadius / maxRadius
                    let blurFracEnd = (clearRadius + blurWidth) / maxRadius
                    
                    // Clamp values so they don’t go out of range
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
                    .blendMode(.multiply) // darkens environment outside the clear zone
                }
                
                // --- Controls ---
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
                        .padding(.vertical, 8)
                }
                .padding(.bottom, 75)
                
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
