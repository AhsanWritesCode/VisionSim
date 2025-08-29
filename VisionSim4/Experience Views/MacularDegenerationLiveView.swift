import SwiftUI

/// Live overlay for simulating macular degeneration.
/// Creates a layered set of blurred circles in the center of the view
/// to mimic progressive central vision loss while keeping the periphery clear.
struct MacularDegenerationLiveView: View {
    @State private var intensity: CGFloat = 0.0  // 0 = clear, 1 = maximum effect
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Transparent base so the real-world scene shows through
                Color.clear.ignoresSafeArea()
                
                // Layered blurred circles forming a soft central blackout
                ZStack {
                    ForEach(0..<6) { i in
                        let level = CGFloat(i)
                        let totalLevels: CGFloat = 6
                        let radius = 100 + (level * 60)   // increasing circle size
                        let opacity = intensity * (1.0 - level / totalLevels)
                        
                        Circle()
                            .fill(Color.black.opacity(opacity))
                            .frame(width: radius, height: radius)
                            .blur(radius: 20)              // smooth transitions
                            .allowsHitTesting(false)
                    }
                }
                
                // --- Controls ---
                VStack {
                    Spacer()
                    
                    Slider(value: $intensity, in: 0...1) {
                        Text("Central Vision Loss")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
                    .frame(maxWidth: 400)
                    
                    Text("Central vision loss: \(Int(intensity * 100))%")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                        .padding(.vertical, 8)
                }
                .padding(.bottom, 30)
                
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
