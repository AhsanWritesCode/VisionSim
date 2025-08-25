// ImpairmentImmersiveOverlay.swift
import SwiftUI

struct ImpairmentImmersiveOverlay: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    @State private var intensity: CGFloat = 0.5
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.clear.ignoresSafeArea()
                
                // Pick the effect based on selected impairment
                switch appState.selectedImpairment {
                case .glaucoma:
                    glaucomaOverlay(intensity: intensity, size: geo.size)
                    
                case .macularDegeneration:
                    mdOverlay(intensity: intensity)
                    
                case .cataracts:
                    cataractsOverlay(intensity: intensity)
                    
                case .diabeticRetinopathy:
                    drOverlay(intensity: intensity, size: geo.size)
                }
                
                // Controls (shared)
                VStack {
                    Spacer()
                    Slider(value: $intensity, in: 0...1) { Text("Severity") }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                        .frame(maxWidth: 420)
                    
                    Text("Severity: \(Int(intensity * 100))%")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                        .padding(.bottom, 10)
                }
                .padding(.bottom, 80)
                
                // Optional: exit immersive
                VStack {
                    HStack {
                        Button("Back") { dismiss() }
                            .buttonStyle(.borderedProminent)
                            .tint(.gray)
                            .padding(.top, geo.safeAreaInsets.top + 12)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    Spacer()
                }
                .ignoresSafeArea(.all, edges: .top)
            }
        }
    }
    
    // === Overlays ===
    
    // Glaucoma: peripheral blackout (your gradient math)
    private func glaucomaOverlay(intensity: CGFloat, size: CGSize) -> some View {
        let maxRadius = hypot(size.width, size.height) / 2
        let clearRadius = maxRadius * (1.0 - intensity)
        let blurWidth: CGFloat = 60
        let cFrac = max(min(clearRadius / maxRadius, 1), 0)
        let bFrac = max(min((clearRadius + blurWidth) / maxRadius, 1), 0)
        
        return RadialGradient(
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
        .blendMode(.multiply)
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
    
    // Macular Degeneration: central scotoma stack (your circle stack)
    private func mdOverlay(intensity: CGFloat) -> some View {
        ZStack {
            ForEach(0..<6) { i in
                let level = CGFloat(i)
                let total: CGFloat = 6
                let radius = 100 + (level * 60)
                let opacity = (intensity * (1.0 - level / total))
                Circle()
                    .fill(Color.black.opacity(opacity))
                    .frame(width: radius, height: radius)
                    .blur(radius: 20)
            }
        }
        .allowsHitTesting(false)
        .ignoresSafeArea()
    }
    
    // Cataracts: desat + slight darken (no white veil)
    private func cataractsOverlay(intensity: CGFloat) -> some View {
        ZStack {
            Rectangle().fill(Color.gray)
                .opacity(intensity * 0.55)
                .blendMode(.saturation)
            Rectangle().fill(Color.black)
                .opacity(intensity * 0.08)
                .blendMode(.multiply)
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
    
    // Diabetic Retinopathy: moving floaters
    private func drOverlay(intensity: CGFloat, size: CGSize) -> some View {
        TimelineView(.animation) { ctx in
            let t = ctx.date.timeIntervalSinceReferenceDate
            let maxFloaters = 25
            let count = Int(intensity * CGFloat(maxFloaters))
            
            // Create floaters separately
            let floaters = (0..<count).map { i -> (CGFloat, CGFloat, CGFloat, CGFloat, Double) in
                let baseX = CGFloat(i % 5) / 5 + 0.1
                let baseY = CGFloat(i / 5) / 5 + 0.1
                let x = baseX + 0.04 * CGFloat(sin(t * 0.8 + Double(i)))
                let y = baseY + 0.05 * CGFloat(cos(t * 1.1 + Double(i)))
                let w: CGFloat = [60, 70, 80, 90, 100].randomElement() ?? 80
                let h: CGFloat = [20, 25, 30, 35, 40].randomElement() ?? 30
                let angle = Double((i * 37) % 360)
                return (x, y, w, h, angle)
            }
            
            ZStack {
                ForEach(Array(floaters.enumerated()), id: \.offset) { _, f in
                    Ellipse()
                        .fill(Color.black)
                        .frame(width: f.2, height: f.3)
                        .blur(radius: 6)
                        .rotationEffect(.degrees(f.4))
                        .position(x: f.0 * size.width, y: f.1 * size.height)
                }
            }
        }
    }
}

