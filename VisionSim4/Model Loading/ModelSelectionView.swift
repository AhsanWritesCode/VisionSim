import SwiftUI
import RealityKit
import RealityKitContent

/// Grid of 3D eye models with lightweight live previews.
/// Tapping a card opens the full interactive viewer in a new window.
struct ModelSelectionView: View {
    @Environment(\.openWindow) private var openWindow
    
    /// Simple model to describe a selectable eye option.
    private struct EyeOption: Identifiable {
        let id = UUID()
        let title: String
        let subtitle: String
        let modelName: String
    }
    
    /// Available models. Titles/subtitles are shown on the card;
    /// modelName matches the .usdz name in your RealityKit bundle.
    private let eyeOptions: [EyeOption] = [
        .init(title: "Normal Eye",               subtitle: "Baseline anatomy",          modelName: "EyeModel"),
        .init(title: "Glaucoma Eye",             subtitle: "Peripheral vision loss",    modelName: "EyeModel_Glaucoma"),
        .init(title: "Cataracts Eye",            subtitle: "Clouded, hazy lens",        modelName: "EyeModel_Cataracts"),
        .init(title: "Macular Degeneration Eye", subtitle: "Central blur & distortion", modelName: "EyeModel_MacularDegeneration"),
        .init(title: "Diabetic Retinopathy Eye", subtitle: "Floaters & patchy vision",  modelName: "EyeModel_DiabeticRetinopathy")
    ]
    
    /// Adaptive grid keeps cards tidy from 2–3 across depending on width.
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 300, maximum: 380), spacing: 24, alignment: .top)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Header
            VStack(alignment: .leading, spacing: 6) {
                Text("Select Eye Model")
                    .font(.largeTitle.weight(.semibold))
                Text("Preview the anatomy and impairment effect, then open the full 3D view.")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 12)
            
            // Grid of previews
            ScrollView {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(eyeOptions) { option in
                        ModelPreviewCard(option: option) {
                            // Opens the dedicated Eye window, passing the model name
                            openWindow(id: "Eye", value: option.modelName)
                        }
                    }
                }
                .padding(.bottom, 24)
            }
        }
        .padding(32)
    }
    
    /// Single card with a looping turntable preview and a text footer.
    private struct ModelPreviewCard: View {
        let option: ModelSelectionView.EyeOption
        let onSelect: () -> Void
        
        @State private var isHovering = false
        
        var body: some View {
            Button(action: onSelect) {
                ZStack {
                    // Card background with a faint outline that brightens on hover
                    RoundedRectangle(cornerRadius: 28)
                        .fill(.thinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(.white.opacity(isHovering ? 0.35 : 0.15),
                                        lineWidth: isHovering ? 2 : 1)
                        )
                    
                    // Lightweight "turntable" animation using TimelineView
                    TimelineView(.animation) { ctx in
                        let t = ctx.date.timeIntervalSinceReferenceDate
                        // Full rotation every 8 seconds
                        let angle = Angle.degrees((t.truncatingRemainder(dividingBy: 8)) / 8 * 360)
                        
                        Model3D(named: option.modelName, bundle: realityKitContentBundle) { model in
                            model
                                .resizable()
                                .scaledToFit()
                                .padding(28)           // give the model breathing room
                                .scaleEffect(0.85)     // keep it clear of the rounded corners
                                .rotation3DEffect(angle, axis: (x: 0, y: 1, z: 0))
                                .allowsHitTesting(false) // gestures go to the card, not the model
                        } placeholder: {
                            ProgressView()
                                .frame(maxHeight: .infinity)
                        }
                    }
                    .padding(4)
                }
                .frame(height: 260)
                // Prevent any 3D edges from peeking outside the rounded rect
                .mask(RoundedRectangle(cornerRadius: 28))
                // Text bar pinned to the bottom-left, always above the model
                .overlay(alignment: .bottomLeading) {
                    HStack(alignment: .firstTextBaseline, spacing: 10) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(option.title).font(.headline)
                            Text(option.subtitle)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding(14)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18))
                    .padding(12)
                    .zIndex(1)
                }
                .contentShape(RoundedRectangle(cornerRadius: 28))
                .shadow(radius: isHovering ? 18 : 8, y: isHovering ? 8 : 4)
            }
            .buttonStyle(.plain)     // keep custom visuals intact
            .hoverEffect(.lift)      // subtle system lift on visionOS/macOS
            .onHover { isHovering = $0 }
        }
    }
}
