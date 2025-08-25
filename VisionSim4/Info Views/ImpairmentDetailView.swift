import SwiftUI

//struct ImpairmentDetailView: View {
//    @Environment(\.openWindow) private var openWindow
//    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
//    @EnvironmentObject var appState: AppState
//
//    let impairment: VisionImpairment
//
//    @State private var showExperienceInstructions = false
//    @State private var experienceWindowToOpen: String?
//    @State private var isImmersiveExperience = false
//
//    // MARK: - Image sets (unchanged for now)
//    var normalImages: [String] {
//        switch impairment {
//        case .macularDegeneration: return ["md_scene_park", "md_scene_street", "md_scene_office"]
//        case .glaucoma: return ["gl_scene_park", "gl_scene_street", "gl_scene_office"]
//        case .cataracts: return ["cat_scene_park", "cat_scene_street", "cat_scene_office"]
//        case .diabeticRetinopathy: return ["dr_scene_park", "dr_scene_street", "dr_scene_office"]
//        }
//    }
//    var impairedImages: [String] {
//        switch impairment {
//        case .macularDegeneration: return ["md_scene_park_impaired", "md_scene_street_impaired", "md_scene_office_impaired"]
//        case .glaucoma: return ["gl_scene_park_impaired", "gl_scene_street_impaired", "gl_scene_office_impaired"]
//        case .cataracts: return ["cat_scene_park_impaired", "cat_scene_street_impaired", "cat_scene_office_impaired"]
//        case .diabeticRetinopathy: return ["dr_scene_park_impaired", "dr_scene_street_impaired", "dr_scene_office_impaired"]
//        }
//    }
//
//    // MARK: - Per-impairment content
//    private var iconName: String {
//        switch impairment {
//        case .macularDegeneration: return "circle.lefthalf.filled"
//        case .glaucoma:            return "eye.trianglebadge.exclamationmark"
//        case .cataracts:           return "aqi.medium"
//        case .diabeticRetinopathy: return "circle.dotted"
//        }
//    }
//    private var color: Color {
//        switch impairment {
//        case .macularDegeneration: return .orange
//        case .glaucoma:            return .teal
//        case .cataracts:           return .yellow
//        case .diabeticRetinopathy: return .red
//        }
//    }
//
//    // Window IDs for interactive + live views
//    private var interactiveWindowID: String {
//        switch impairment {
//        case .macularDegeneration: return "macularDegenerationInteractive"
//        case .glaucoma:            return "glaucomaInteractive"
//        case .cataracts:           return "cataractsInteractive"
//        case .diabeticRetinopathy: return "diabeticRetinopathyInteractive"
//        }
//    }
//    private var liveWindowID: String? {
//        switch impairment {
//        case .macularDegeneration: return "macularDegenerationOverlay"
//        case .glaucoma:            return "glaucomaImmersive"
//        case .cataracts:           return "cataractsOverlay"
//        case .diabeticRetinopathy: return "diabeticRetinopathyLive"
//        }
//    }
//
//    var body: some View {
//        ScrollView {  // smoother on small windows; removes hard edges
//            VStack(spacing: 28) {
//
//                // HEADER
//                VStack(spacing: 6) {
//                    HStack(spacing: 12) {
//                        ZStack {
//                            Circle().fill(color.opacity(0.2))
//                            Image(systemName: iconName)
//                                .font(.system(size: 22, weight: .semibold))
//                                .foregroundStyle(color)
//                        }
//                        .frame(width: 40, height: 40)
//
//                        Text(impairment.rawValue)
//                            .font(.system(.largeTitle, design: .rounded).weight(.bold))
//                        Spacer(minLength: 0)
//                    }
//                    Text(subtitle(for: impairment))
//                        .font(.callout)
//                        .foregroundStyle(.secondary)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//
//                // CARDS
//                ActionCard(
//                    title: "Interactive Visualization",
//                    subtitle: "Use preset photos. Adjust severity with a slider and compare normal vs affected vision.",
//                    icon: "slider.horizontal.3",
//                    accent: color
//                ) {
//                    experienceWindowToOpen = interactiveWindowID
//                    showExperienceInstructions = true
//                }
//
//                if let liveID = liveWindowID {
//                    ActionCard(
//                        title: "Real-World Overlay",
//                        subtitle: "Apply the effect to your surroundings for an in-situ experience.",
//                        icon: "viewfinder",
//                        accent: color
//                    ) {
//                        // open directly for live overlays (no instructions sheet)
//                        appState.selectedImpairment = impairment   // ✅ ensure correct impairment (fixes old cataracts bug)
//                        openWindow(id: liveID)
//                    }
//                }
//
//                // OPTIONAL: quick tip
//                TipRow(text: "You can reposition the window to different backgrounds to see how lighting changes the effect.")
//
//                Spacer(minLength: 8)
//            }
//            .padding(28)
//        }
//        .sheet(isPresented: $showExperienceInstructions) {
//            InstructionSheet(
//                startTapped: {
//                    showExperienceInstructions = false
//                    appState.selectedImpairment = impairment
//                    if isImmersiveExperience {
//                        Task {
//                            await openImmersiveSpace(id: "glaucomaImmersive")
//                            isImmersiveExperience = false
//                        }
//                    } else if let id = experienceWindowToOpen {
//                        openWindow(id: id)
//                    }
//                },
//                accent: color
//            )
//            .presentationDetents([.medium])
//        }
//    }
//
//    // concise per-impairment blurb
//    private func subtitle(for i: VisionImpairment) -> String {
//        switch i {
//        case .macularDegeneration: return "Explore central vision loss and its impact on reading and face recognition."
//        case .glaucoma:            return "Experience peripheral field loss and tunnel vision effects."
//        case .cataracts:           return "See how haze, diffusion, and reduced contrast affect everyday scenes."
//        case .diabeticRetinopathy: return "Simulate floaters, blotches, and fluctuating clarity."
//        }
//    }
//}

// Glassy card with subtle depth, icon, and primary action button
struct ActionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let accent: Color
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12).fill(accent.opacity(0.18))
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(accent)
                }
                .frame(width: 44, height: 44)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.title3.weight(.semibold))
                    Text(subtitle)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }

            Button(action: action) {
                HStack {
                    Text("Start")
                    Image(systemName: "arrow.forward.circle.fill")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(FilledGlassButtonStyle(accent: accent))
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.08), radius: 18, y: 8)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(.white.opacity(0.25), lineWidth: 0.5)
        )
        .hoverEffect(.lift)
    }
}

struct TipRow: View {
    let text: String
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "lightbulb")
            Text(text)
                .font(.footnote)
            Spacer(minLength: 0)
        }
        .foregroundStyle(.secondary)
        .padding(.horizontal, 6)
    }
}

// Polished primary button
struct FilledGlassButtonStyle: ButtonStyle {
    var accent: Color = .blue
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(accent.gradient.opacity(configuration.isPressed ? 0.85 : 1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(.white.opacity(0.35), lineWidth: 0.5)
            )
            .foregroundStyle(.white)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.28, dampingFraction: 0.8), value: configuration.isPressed)
    }
}


struct InstructionSheet: View {
    let startTapped: () -> Void
    var accent: Color

    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 12) {
                ZStack {
                    Circle().fill(accent.opacity(0.15))
                    Image(systemName: "rectangle.and.hand.point.up.left.filled")
                        .foregroundStyle(accent)
                        .font(.system(size: 18, weight: .semibold))
                }
                .frame(width: 40, height: 40)

                Text("How to Use the Simulator")
                    .font(.title2.bold())
                Spacer()
            }

            VStack(alignment: .leading, spacing: 10) {
                Label("Use the slider to change severity.", systemImage: "slider.horizontal.3")
                Label("Observe how visibility and contrast are affected.", systemImage: "eye")
                Label("Try different backgrounds & lighting.", systemImage: "lightbulb")
            }
            .font(.callout)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)

            Button {
                startTapped()
            } label: {
                HStack {
                    Text("Start Experience")
                    Image(systemName: "arrow.forward.circle.fill")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(FilledGlassButtonStyle(accent: accent))
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .presentationBackground(.clear) // keeps the sheet glassy over your window
    }
}
// ImpairmentDetailView.swift
import SwiftUI

struct ImpairmentDetailView: View {
    @Environment(\.openWindow) private var openWindow
    @EnvironmentObject var appState: AppState

    let impairment: VisionImpairment

    @State private var showExperienceInstructions = false
    @State private var experienceWindowToOpen: String?

    // MARK: - Per-impairment UI
    private var iconName: String {
        switch impairment {
        case .macularDegeneration: return "circle.lefthalf.filled"
        case .glaucoma:            return "eye.trianglebadge.exclamationmark"
        case .cataracts:           return "aqi.medium"
        case .diabeticRetinopathy: return "circle.dotted"
        }
    }
    private var color: Color {
        switch impairment {
        case .macularDegeneration: return .orange
        case .glaucoma:            return .teal
        case .cataracts:           return .yellow
        case .diabeticRetinopathy: return .red
        }
    }

    // Interactive window ids
    private var interactiveWindowID: String {
        switch impairment {
        case .macularDegeneration: return "macularDegenerationInteractive"
        case .glaucoma:            return "glaucomaInteractive"
        case .cataracts:           return "cataractsInteractive"
        case .diabeticRetinopathy: return "diabeticRetinopathyInteractive"
        }
    }

    // Live “real-world overlay” window ids
    private var liveWindowID: String {
        switch impairment {
        case .macularDegeneration: return "macularDegenerationOverlay"
        case .glaucoma:            return "glaucomaLiveOverlay"
        case .cataracts:           return "cataractsOverlay"
        case .diabeticRetinopathy: return "diabeticRetinopathyLive"
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                // Header
                VStack(spacing: 6) {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle().fill(color.opacity(0.2))
                            Image(systemName: iconName)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(color)
                        }
                        .frame(width: 40, height: 40)

                        Text(impairment.rawValue)
                            .font(.system(.largeTitle, design: .rounded).weight(.bold))
                        Spacer()
                    }
                    Text(subtitle(for: impairment))
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                // Interactive card (preset images)
                ActionCard(
                    title: "Interactive Visualization",
                    subtitle: "Use preset photos. Adjust severity with a slider and compare normal vs affected vision.",
                    icon: "slider.horizontal.3",
                    accent: color
                ) {
                    experienceWindowToOpen = interactiveWindowID
                    showExperienceInstructions = true
                }

                // Real-world overlay (window)
                ActionCard(
                    title: "Real-World Overlay",
                    subtitle: "Apply the effect to your surroundings for an in-situ experience.",
                    icon: "viewfinder",
                    accent: color
                ) {
                    appState.selectedImpairment = impairment
                    openWindow(id: liveWindowID)   // ← back to windows
                }

                TipRow(text: "You can reposition the window to different backgrounds to see how lighting changes the effect.")
                Spacer(minLength: 8)
            }
            .padding(28)
        }
        .sheet(isPresented: $showExperienceInstructions) {
            InstructionSheet(
                startTapped: {
                    showExperienceInstructions = false
                    appState.selectedImpairment = impairment
                    if let id = experienceWindowToOpen { openWindow(id: id) }
                },
                accent: color
            )
            #if os(visionOS)
            .presentationDetents([.fraction(0.45)])
            #else
            .presentationDetents([.medium])
            #endif
        }
    }

    private func subtitle(for i: VisionImpairment) -> String {
        switch i {
        case .macularDegeneration: return "Explore central vision loss and its impact on reading and face recognition."
        case .glaucoma:            return "Experience peripheral field loss and tunnel vision effects."
        case .cataracts:           return "See how haze, diffusion, and reduced contrast affect everyday scenes."
        case .diabeticRetinopathy: return "Simulate floaters, blotches, and fluctuating clarity."
        }
    }
}

// ——— your ActionCard / TipRow / FilledGlassButtonStyle / InstructionSheet components from earlier remain unchanged ———
