// Info Panel View

import SwiftUI

// A movable Info Panel that displays details about a selected vision impairment.
struct InfoPanelView: View {
    let impairment: VisionImpairment
    
    // Lets users dismiss this window by tapping done.
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            VStack {
                // Main text block
                VStack(spacing: 25) {
                    Text("About \(impairment.rawValue)")
                        .font(.title2) // Medium title font
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
                                    Text("Overview")
                                        .font(.headline)
                                    switch impairment {
                                    case .glaucoma:
                                        Text("Glaucoma is a group of eye conditions that damage the optic nerve, often due to high eye pressure. It causes peripheral vision loss and can lead to blindness if untreated.")
                                    case .cataracts:
                                        Text("Cataracts occur when the lens of the eye becomes cloudy, leading to blurred vision, faded colors, and difficulty seeing at night. Surgery is often required to restore vision.")
                                    case .macularDegeneration:
                                        Text("Macular degeneration is a disease that affects the central part of the retina, causing central vision loss. It primarily impacts older adults and can be dry or wet in form.")
                                    case .diabeticRetinopathy:
                                        Text("Diabetic retinopathy is a complication of diabetes that affects the eyes. It is caused by damage to the blood vessels of the retina and can lead to vision loss if untreated.")
                                    }
                                }

                                Group {
                                    Text("Symptoms")
                                        .font(.headline)
                                    switch impairment {
                                    case .glaucoma:
                                        Text("Gradual peripheral vision loss, tunnel vision, eye pain, and blurred vision.")
                                    case .cataracts:
                                        Text("Cloudy or blurry vision, faded colors, glare or halos around lights, poor night vision.")
                                    case .macularDegeneration:
                                        Text("Blurred or reduced central vision, difficulty recognizing faces, straight lines appearing wavy.")
                                    case .diabeticRetinopathy:
                                        Text("Floaters, blurred vision, impaired color vision, dark or empty areas in your vision, vision loss.")
                                    }
                                }

                                Group {
                                    Text("Treatment")
                                        .font(.headline)
                                    switch impairment {
                                    case .glaucoma:
                                        Text("Prescription eye drops, oral medications, laser therapy, or surgery to reduce eye pressure.")
                                    case .cataracts:
                                        Text("Surgery to replace the cloudy lens with a clear artificial one.")
                                    case .macularDegeneration:
                                        Text("Anti-VEGF injections, laser therapy, dietary supplements for dry form, and vision aids.")
                                    case .diabeticRetinopathy:
                                        Text("Blood sugar control, anti-VEGF therapy, laser treatment, and vitrectomy surgery in advanced cases.")
                                    }
                                }

                                Group {
                                    Text("Risk Factors")
                                        .font(.headline)
                                    switch impairment {
                                    case .glaucoma:
                                        Text("Age over 60, family history, high eye pressure, diabetes, and African or Hispanic descent.")
                                    case .cataracts:
                                        Text("Aging, diabetes, smoking, prolonged sun exposure, and alcohol use.")
                                    case .macularDegeneration:
                                        Text("Age over 50, smoking, obesity, high blood pressure, and family history.")
                                    case .diabeticRetinopathy:
                                        Text("Diabetes duration, poor blood sugar control, high blood pressure, high cholesterol, pregnancy, tobacco use.")
                                    }
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
            }
            .padding()

            VStack {
                HStack {
                    Spacer()
                    Button("Done") {
                        dismiss()
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
}
