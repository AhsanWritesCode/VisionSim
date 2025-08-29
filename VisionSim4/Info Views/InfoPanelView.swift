import SwiftUI

/// Panel that shows educational content for a specific impairment.
/// Uses a simple top bar and a stack of glassy info cards.
struct InfoPanelView: View {
    let impairment: VisionImpairment
    @Environment(\.dismiss) private var dismiss

    // Accent color keyed to the selected impairment
    private var accent: Color {
        switch impairment {
        case .macularDegeneration: return .orange
        case .glaucoma:            return .teal
        case .cataracts:           return .yellow
        case .diabeticRetinopathy: return .red
        }
    }

    // SF Symbol to visually differentiate sections by impairment
    private var iconName: String {
        switch impairment {
        case .macularDegeneration: return "circle.lefthalf.filled"
        case .glaucoma:            return "eye.trianglebadge.exclamationmark"
        case .cataracts:           return "aqi.medium"
        case .diabeticRetinopathy: return "circle.dotted"
        }
    }

    var body: some View {
        ZStack {
            // Dim layer to help the sheet pop against busy backgrounds
            Color.black.opacity(0.2).ignoresSafeArea()

            // Main sheet container
            VStack(spacing: 0) {
                // Top bar with symmetrical Back/Done actions
                HStack {
                    Button("Back") { dismiss() }
                        .buttonStyle(TopBarButton(accent: accent))
                    Spacer()
                    Button("Done") { dismiss() }
                        .buttonStyle(TopBarButton(accent: accent))
                }
                .padding(.horizontal, 32)
                .padding(.top, 24)

                // Scrollable content area
                ScrollView {
                    VStack(spacing: 32) {
                        // Header: icon, title, short blurb
                        VStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(accent.gradient)
                                    .frame(width: 70, height: 70)
                                Image(systemName: iconName)
                                    .font(.system(size: 30, weight: .semibold))
                                    .foregroundStyle(.white)
                            }

                            Text(impairment.rawValue)
                                .font(.largeTitle.bold())
                                .foregroundStyle(.primary)

                            Text("Learn about causes, symptoms, treatments, and risk factors")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: 480)
                        }
                        .padding(.top, 8)

                        // Content blocks pulled from the impairment’s computed properties
                        InfoCard(title: "Overview",     text: impairment.overview,     accent: accent)
                        InfoCard(title: "Symptoms",     text: impairment.symptoms,     accent: accent)
                        InfoCard(title: "Treatment",    text: impairment.treatment,    accent: accent)
                        InfoCard(title: "Risk Factors", text: impairment.riskFactors,  accent: accent)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

// MARK: - Components

/// Reusable glass card for a titled text section
private struct InfoCard: View {
    let title: String
    let text: String
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "circle.fill")
                    .font(.system(size: 10))
                    .foregroundStyle(accent)
                Text(title)
                    .font(.headline.weight(.semibold))
            }
            Text(text.trimmingCharacters(in: .whitespacesAndNewlines))
                .font(.body)
                .lineSpacing(3)
                .foregroundStyle(.primary)
        }
        .padding(20)
        .frame(maxWidth: 700, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 10, y: 5)
    }
}

/// Rounded capsule button style used in the top bar
private struct TopBarButton: ButtonStyle {
    var accent: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(accent.opacity(configuration.isPressed ? 0.6 : 0.8))
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}
