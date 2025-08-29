import SwiftUI

struct ImpairmentDetailView: View {
    @Environment(\.openWindow) private var openWindow
    @EnvironmentObject var appState: AppState

    let impairment: VisionImpairment

    @State private var showExperienceInstructions = false
    @State private var experienceWindowToOpen: String?

    // MARK: - Per-impairment UI
    /// SF Symbol chosen per impairment for a quick visual cue
    private var iconName: String {
        switch impairment {
        case .macularDegeneration: return "circle.lefthalf.filled"
        case .glaucoma:            return "eye.trianglebadge.exclamationmark"
        case .cataracts:           return "aqi.medium"
        case .diabeticRetinopathy: return "circle.dotted"
        }
    }
    /// Accent color per impairment to keep the theme consistent
    private var color: Color {
        switch impairment {
        case .macularDegeneration: return .orange
        case .glaucoma:            return .teal
        case .cataracts:           return .yellow
        case .diabeticRetinopathy: return .red
        }
    }

    // Window IDs for the image-based interactive views
    private var interactiveWindowID: String {
        switch impairment {
        case .macularDegeneration: return "macularDegenerationInteractive"
        case .glaucoma:            return "glaucomaInteractive"
        case .cataracts:           return "cataractsInteractive"
        case .diabeticRetinopathy: return "diabeticRetinopathyInteractive"
        }
    }

    // Window IDs for the live “real-world overlay” views
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
                // Header: icon + name + short blurb
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

                // Educational content: opens a dedicated info panel
                ActionCard(
                    title: "Learn About \(impairment.rawValue)",
                    subtitle: "Causes, symptoms, treatments, risk factors, and everyday challenges.",
                    icon: "text.book.closed.fill",
                    accent: color
                ) {
                    appState.selectedImpairment = impairment
                    // Using the raw string ID so this view doesn’t depend on the App’s enum
                    openWindow(id: "infoPanel")
                }

                // Image-based interactive preview (with slider etc.)
                ActionCard(
                    title: "Interactive Visualization",
                    subtitle: "Use preset photos. Adjust severity with a slider and compare normal vs affected vision.",
                    icon: "slider.horizontal.3",
                    accent: color
                ) {
                    experienceWindowToOpen = interactiveWindowID
                    showExperienceInstructions = true
                }

                // Live overlay version: applies the effect over the current environment
                ActionCard(
                    title: "Real-World Overlay",
                    subtitle: "Apply the effect to your surroundings for an in-situ experience.",
                    icon: "viewfinder",
                    accent: color
                ) {
                    appState.selectedImpairment = impairment
                    openWindow(id: liveWindowID)
                }

                // Small UX nudge
                TipRow(text: "You can reposition the window to different backgrounds to see how lighting changes the effect.")
                Spacer(minLength: 8)
            }
            .padding(28)
        }
        // Simple pre-flight sheet before launching the interactive window
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

    /// Short description tailored to each impairment
    private func subtitle(for i: VisionImpairment) -> String {
        switch i {
        case .macularDegeneration: return "Explore central vision loss and its impact on reading and face recognition."
        case .glaucoma:            return "Experience peripheral field loss and tunnel vision effects."
        case .cataracts:           return "See how haze, diffusion, and reduced contrast affect everyday scenes."
        case .diabeticRetinopathy: return "Simulate floaters, blotches, and fluctuating clarity."
        }
    }
}


/// Glassy card with icon, copy, and a single primary action.
/// Used for “Learn”, “Interactive”, and “Overlay” actions above.
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

/// Small helper row for nudges/tips under the action stack.
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

/// Primary button style used across the cards.
/// Slight glass effect with a subtle press animation.
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

/// One-time instruction sheet shown before launching an experience.
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
        .presentationBackground(.clear) // keeps the sheet glassy over the underlying window
    }
}
