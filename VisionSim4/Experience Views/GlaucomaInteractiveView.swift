import SwiftUI

struct GlaucomaInteractiveView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var intensity: CGFloat = 0.0   // 0 = no blackout, 1 = full blackout
    let imageName: String                         // e.g. "gl_scene_park"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Base image
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // Vignette effect
                GeometryReader { geo in
                    let maxRadius = hypot(geo.size.width, geo.size.height) / 2
                    let clearRadius = maxRadius * (1.0 - intensity)
                    let blurWidth: CGFloat = 60
                    let clearFrac   = (clearRadius / maxRadius)
                    let blurFracEnd = ((clearRadius + blurWidth) / maxRadius)
                    let cFrac = min(max(clearFrac, 0), 1)
                    let bFrac = min(max(blurFracEnd, 0), 1)
                    
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
                
                // UI
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
                        .background(.ultraThinMaterial) // Adds blurred background for contrast
                        .cornerRadius(10)
                        .foregroundColor(.primary) // Adapts to light/dark modes
                }
                .padding(.bottom, 150)
                
                
                // Back button - placed independently in top-left corner
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
