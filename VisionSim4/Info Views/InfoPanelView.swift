import SwiftUI

struct InfoPanelView: View {
    let impairment: VisionImpairment
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            VStack {
                // Top Bar with Back and Done
                HStack {
                    BackToHomeButton()
                        .padding(.leading, 20)
                        .padding(.top, 20)

                    Spacer()

                    Button("Done") {
                        dismiss()
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 20)
                }

                Spacer()

                // Main Info Panel Content
                VStack(spacing: 25) {
                    Text("About \(impairment.rawValue)")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)

                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                            .shadow(radius: 10)
                            .frame(maxWidth: 500)

                        ScrollView {
                            VStack(alignment: .leading, spacing: 20) {
                                Group {
                                    Text("Overview").font(.headline)
                                    Text(overviewText(for: impairment))

                                    Text("Symptoms").font(.headline)
                                    Text(symptomsText(for: impairment))

                                    Text("Treatment").font(.headline)
                                    Text(treatmentText(for: impairment))

                                    Text("Risk Factors").font(.headline)
                                    Text(riskFactorsText(for: impairment))
                                }
                            }
                            .font(.body)
                            .foregroundStyle(.primary)
                            .padding()
                            .frame(maxWidth: 450, alignment: .leading)
                        }
                    }
                    .padding(.top)
                }

                Spacer()
            }
            .padding()
        }
    }

    // MARK: - Text Generators

    func overviewText(for impairment: VisionImpairment) -> String {
        switch impairment {
        case .glaucoma:
            return "Glaucoma is a group of eye conditions that damage the optic nerve, often due to high eye pressure..."
        case .cataracts:
            return "Cataracts occur when the lens of the eye becomes cloudy, leading to blurred vision..."
        case .macularDegeneration:
            return "Macular degeneration affects the central retina, causing central vision loss..."
        case .diabeticRetinopathy:
            return "Diabetic retinopathy is a complication of diabetes that damages the retina's blood vessels..."
        }
    }

    func symptomsText(for impairment: VisionImpairment) -> String {
        switch impairment {
        case .glaucoma:
            return "Gradual peripheral vision loss, tunnel vision, eye pain, and blurred vision."
        case .cataracts:
            return "Cloudy or blurry vision, faded colors, glare or halos around lights, poor night vision."
        case .macularDegeneration:
            return "Blurred or reduced central vision, difficulty recognizing faces, straight lines appearing wavy."
        case .diabeticRetinopathy:
            return "Floaters, blurred vision, impaired color vision, dark or empty areas, vision loss."
        }
    }

    func treatmentText(for impairment: VisionImpairment) -> String {
        switch impairment {
        case .glaucoma:
            return "Prescription eye drops, oral medications, laser therapy, or surgery."
        case .cataracts:
            return "Surgery to replace the cloudy lens with a clear artificial one."
        case .macularDegeneration:
            return "Anti-VEGF injections, laser therapy, dietary supplements, and vision aids."
        case .diabeticRetinopathy:
            return "Blood sugar control, anti-VEGF therapy, laser treatment, and vitrectomy surgery."
        }
    }

    func riskFactorsText(for impairment: VisionImpairment) -> String {
        switch impairment {
        case .glaucoma:
            return "Age over 60, family history, high eye pressure, diabetes, and certain ethnicities."
        case .cataracts:
            return "Aging, diabetes, smoking, prolonged sun exposure, alcohol use."
        case .macularDegeneration:
            return "Age over 50, smoking, obesity, high blood pressure, family history."
        case .diabeticRetinopathy:
            return "Diabetes duration, poor control, high blood pressure, cholesterol, pregnancy, smoking."
        }
    }
}
