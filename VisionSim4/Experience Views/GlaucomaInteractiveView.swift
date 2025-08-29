import SwiftUI

/// Interactive preset view for simulating glaucoma vision loss.
/// Uses a vignette-style radial gradient to mimic peripheral blackout.
struct GlaucomaInteractiveView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var intensity: CGFloat = 0.0   // 0 = clear, 1 = fully dark edges
    let imageName: String                         // background photo (e.g. "gl_scene_park")
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Base background image
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // Radial vignette overlay that closes in as intensity increases
                GeometryReader { geo in
                    let maxRadius = hypot(geo.size.width, geo.size.height) / 2
                    let clearRadius = maxRadius * (1.0 - intensity)     // radius of fully visible center
                    let blurWidth: CGFloat = 60                        // soft fade-out size
                    let clearFrac   = (clearRadius / maxRadius)
                    let blurFracEnd = ((clearRadius + blurWidth) / maxRadius)
                    let cFrac = min(max(clearFrac, 0), 1)
                    let bFrac = min(max(blurFracEnd, 0), 1)
                    
                    let gradient = RadialGradient(
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
                    
                    gradient
                        .ignoresSafeArea()
                        .blendMode(.multiply) // darkens image outside central region
                }
                
                // Controls: slider + readout
                VStack {
                    Spacer()
                    
                    Slider(value: $intensity, in: 0...1) {
                        Text("Peripheral Vision Loss")
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .frame(maxWidth: 400)
                    
                    Text("Peripheral vision loss: \(Int(intensity * 100))%")
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.ultraThinMaterial)  // ensure text remains legible
                        .cornerRadius(10)
                        .foregroundColor(.primary)
                }
                .padding(.bottom, 150)
                
                // Back button pinned top-left
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
