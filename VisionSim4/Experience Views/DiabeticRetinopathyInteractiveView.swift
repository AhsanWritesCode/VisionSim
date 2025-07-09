import SwiftUI

struct DiabeticRetinopathyInteractiveView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var floaterDensity: CGFloat = 0.0
    let imageName: String
    
    private let maxFloaters = 20
    private let randomFloaterPositions: [CGPoint] = (0..<40).map { _ in
        CGPoint(x: CGFloat.random(in: 0.0...1.0), y: CGFloat.random(in: 0.0...1.0))
    }
    
    private let randomFloaterAngles: [Angle] = (0..<40).map { _ in
        Angle.degrees(Double.random(in: 0..<360))
    }
    
    private let randomFloaterSizes: [CGSize] = (0..<40).map { _ in
        let width = CGFloat.random(in: 60...100)
        let height = CGFloat.random(in: 20...40)
        return CGSize(width: width, height: height)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                
                // Floaters (overlay ellipses)
                let count = Int(floaterDensity * CGFloat(maxFloaters))
                ForEach(0..<count, id: \.self) { i in
                    let pos = randomFloaterPositions[i]
                    let angle = randomFloaterAngles[i]
                    let size = randomFloaterSizes[i]
                    Ellipse()
                        .fill(Color.black)
                        .frame(width: size.width, height: size.height)
                        .blur(radius: 6)
                        .rotationEffect(angle)
                        .position(
                            x: pos.x * geometry.size.width,
                            y: pos.y * geometry.size.height
                        )
                }
                
                VStack {
                    Spacer()
                    
                    // Slider
                    Slider(value: $floaterDensity, in: 0...1) {
                        Text("Floaters")
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .frame(maxWidth: 400)
                    
                    // Intensity label (wrapped for visibility)
                    Text("Floaters: \(Int(floaterDensity * 100))%")
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                        .foregroundColor(.primary)
                    

                }
                .padding(.bottom, 75)
                
                
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
