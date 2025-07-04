import SwiftUI

struct WalkthroughStepView: View {
    let impairment: VisionImpairment

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Impairment Title (stretches full width)
                Text(impairment.rawValue)
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 8)

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
                .foregroundColor(.primary)

                Divider()
                    .padding(.vertical)

                Text("Interactive Demo")
                    .font(.headline)
                    .padding(.bottom, 8)

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
                .aspectRatio(1.6, contentMode: .fit)
                .cornerRadius(20)
                .clipped()
                
                Divider()
                    .padding(.vertical)

                QuizView(question: getQuiz(for: impairment))

            }
            .padding()
            .frame(maxWidth: 800)
        }
    }

    private func SectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.title3)
            .bold()
            .foregroundColor(.primary)
            .padding(.top, 12)
    }
    
    func getQuiz(for impairment: VisionImpairment) -> QuizQuestion {
        switch impairment {
        case .glaucoma:
            return QuizQuestion(
                question: "Which part of vision is typically affected first in glaucoma?",
                options: ["Central vision", "Color vision", "Peripheral vision", "Night vision"],
                correctIndex: 2
            )
        case .cataracts:
            return QuizQuestion(
                question: "What is the most common treatment for cataracts?",
                options: ["Eye drops", "Laser therapy", "Sunglasses", "Surgery"],
                correctIndex: 3
            )
        case .macularDegeneration:
            return QuizQuestion(
                question: "Macular degeneration affects which part of the eye?",
                options: ["Cornea", "Optic nerve", "Retina", "Lens"],
                correctIndex: 2
            )
        case .diabeticRetinopathy:
            return QuizQuestion(
                question: "Diabetic retinopathy is caused by damage to which structures?",
                options: ["Iris", "Retinal blood vessels", "Cornea", "Pupil"],
                correctIndex: 1
            )
        }
    }

}

