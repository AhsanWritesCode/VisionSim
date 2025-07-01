import SwiftUI

struct WalkthroughStepView: View {
    let impairment: VisionImpairment

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(impairment.rawValue)
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)

                // Informational Sections
                Group {
                    SectionHeader("Overview")
                    Text(impairment.overview)

                    SectionHeader("Symptoms")
                    Text(impairment.symptoms)

                    SectionHeader("Treatment")
                    Text(impairment.treatment)

                    SectionHeader("Risk Factors")
                    Text(impairment.riskFactors)
                }
                .font(.body)

                Divider()
                    .padding(.vertical)

                Text("Interactive Demo")
                    .font(.headline)

                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.1))
                        .overlay(
                            GeometryReader { geo in
                                VStack {
                                    switch impairment {
                                    case .glaucoma:
                                        GlaucomaInteractiveView(imageName: "gl_scene_park")
                                            .frame(width: geo.size.width, height: geo.size.height)
                                    case .cataracts:
                                        CataractsInteractiveView(imageName: "cat_scene_park")
                                            .frame(width: geo.size.width, height: geo.size.height)
                                    case .macularDegeneration:
                                        MacularDegenerationInteractiveView(imageName: "md_scene_park")
                                            .frame(width: geo.size.width, height: geo.size.height)
                                    case .diabeticRetinopathy:
                                        DiabeticRetinopathyInteractiveView(imageName: "md_scene_park")
                                            .frame(width: geo.size.width, height: geo.size.height)
                                    }
                                }
                            }
                        )
                }
                .aspectRatio(1.6, contentMode: .fit) // Adjust ratio as needed
                .cornerRadius(20)
                .clipped()
            }
        }
    }

    private func SectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.accentColor)
            .padding(.top, 8)
    }
}
