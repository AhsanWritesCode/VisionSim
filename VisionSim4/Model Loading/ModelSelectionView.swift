import SwiftUI
import RealityKit
import RealityKitContent

struct ModelSelectionView: View {
    @Environment(\.openWindow) private var openWindow
    
    private struct EyeOption: Identifiable {
        let id = UUID()
        let title: String
        let subtitle: String
        let modelName: String
    }
    
    private let eyeOptions: [EyeOption] = [
        .init(title: "Normal Eye",               subtitle: "Baseline anatomy",             modelName: "EyeModel"),
        .init(title: "Glaucoma Eye",             subtitle: "Peripheral vision loss",       modelName: "EyeModel_Glaucoma"),
        .init(title: "Cataracts Eye",            subtitle: "Clouded, hazy lens",           modelName: "EyeModel_Cataracts"),
        .init(title: "Macular Degeneration Eye", subtitle: "Central blur & distortion",    modelName: "EyeModel_MacularDegeneration"),
        .init(title: "Diabetic Retinopathy Eye", subtitle: "Floaters & patchy vision",     modelName: "EyeModel_DiabeticRetinopathy"),
        .init(title: "Book", subtitle: "Book test",     modelName: "book_scaled")
    ]
    
    // Adaptive grid: 2–3 cards depending on window width
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 300, maximum: 380), spacing: 24, alignment: .top)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Select Eye Model").font(.largeTitle.weight(.semibold))
                Text("Preview the anatomy and impairment effect, then open the full 3D view.")
                    .font(.callout).foregroundStyle(.secondary)
            }
            .padding(.top, 12)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(eyeOptions) { option in
                        ModelPreviewCard(option: option) {
                            openWindow(id: "Eye", value: option.modelName)
                        }
                    }
                }
                .padding(.bottom, 24)
            }
        }
        .padding(32)
    }
    
    private struct ModelPreviewCard: View {
        let option: ModelSelectionView.EyeOption
        let onSelect: () -> Void
        
        @State private var isHovering = false
        
        var body: some View {
            Button(action: onSelect) {
                ZStack {
                    // Card background + subtle border
                    RoundedRectangle(cornerRadius: 28)
                        .fill(.thinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(.white.opacity(isHovering ? 0.35 : 0.15),
                                        lineWidth: isHovering ? 2 : 1)
                        )
                    
                    // Live preview (kept smaller + clipped by mask below)
                    TimelineView(.animation) { ctx in
                        let t = ctx.date.timeIntervalSinceReferenceDate
                        let angle = Angle.degrees((t.truncatingRemainder(dividingBy: 8)) / 8 * 360)
                        
                        Model3D(named: option.modelName, bundle: realityKitContentBundle) { model in
                            model
                                .resizable()
                                .scaledToFit()
                                .padding(28)              // ↓ makes it smaller
                                .scaleEffect(0.85)        // ↓ extra headroom inside the card
                                .rotation3DEffect(angle, axis: (x: 0, y: 1, z: 0))
                                .allowsHitTesting(false)
                        } placeholder: {
                            ProgressView().frame(maxHeight: .infinity)
                        }
                    }
                    .padding(4)
                }
                .frame(height: 260)
                // Ensures the 3D content never bleeds outside the rounded rect
                .mask(RoundedRectangle(cornerRadius: 28))
                .overlay(alignment: .bottomLeading) {
                    // Always-on-top text bar
                    HStack(alignment: .firstTextBaseline, spacing: 10) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(option.title).font(.headline)
                            Text(option.subtitle).font(.footnote).foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding(14)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18))
                    .padding(12)
                    .zIndex(1) // keep above everything
                }
                .contentShape(RoundedRectangle(cornerRadius: 28))
                .shadow(radius: isHovering ? 18 : 8, y: isHovering ? 8 : 4)
            }
            .buttonStyle(.plain)
            .hoverEffect(.lift)
            .onHover { isHovering = $0 }
        }
    }
}
