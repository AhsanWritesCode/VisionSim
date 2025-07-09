import SwiftUI

struct MacularDegenerationLiveView: View {
    @State private var intensity: CGFloat = 0.0  // 0 = clear, 1 = full effect
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear.ignoresSafeArea()
                
                // Simulated central blur using layered blurred circles
                ZStack {
                    ForEach(0..<6) { i in
                        let level = CGFloat(i)
                        let totalLevels: CGFloat = 6
                        let radius = 100 + (level * 60)
                        let opacity = (intensity * (1.0 - level / totalLevels)) * 1
                        
                        Circle()
                            .fill(Color.black.opacity(opacity))
                            .frame(width: radius, height: radius)
                            .blur(radius: 20)
                            .allowsHitTesting(false)
                    }
                }
                
                // UI controls
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
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                }
                .padding(.bottom, 30)
                
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
