// Impairment Detail View

import SwiftUI

struct ImpairmentDetailView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @EnvironmentObject var appState: AppState

    let impairment: VisionImpairment

    @State private var showExperienceInstructions = false
    @State private var experienceWindowToOpen: String?
    @State private var isImmersiveExperience = false

    var normalImages: [String] {
        switch impairment {
        case .macularDegeneration: return ["md_scene_park", "md_scene_street", "md_scene_office"]
        case .glaucoma: return ["gl_scene_park", "gl_scene_street", "gl_scene_office"]
        case .cataracts: return ["cat_scene_park", "cat_scene_street", "cat_scene_office"]
        case .diabeticRetinopathy: return ["dr_scene_park", "dr_scene_street", "dr_scene_office"]
        }
    }

    var impairedImages: [String] {
        switch impairment {
        case .macularDegeneration: return ["md_scene_park_impaired", "md_scene_street_impaired", "md_scene_office_impaired"]
        case .glaucoma: return ["gl_scene_park_impaired", "gl_scene_street_impaired", "gl_scene_office_impaired"]
        case .cataracts: return ["cat_scene_park_impaired", "cat_scene_street_impaired", "cat_scene_office_impaired"]
        case .diabeticRetinopathy: return ["dr_scene_park_impaired", "dr_scene_street_impaired", "dr_scene_office_impaired"]
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Button("Learn About \(impairment.rawValue)") {
                appState.selectedImpairment = impairment
                openWindow(id: "infoPanel")
            }
            .buttonStyle(CustomButtonStyle())

            Button("See Normal View") {
                appState.selectedImpairment = impairment
                openWindow(id: "normalView")
            }
            .buttonStyle(CustomButtonStyle())

            Button("See Impaired View") {
                appState.selectedImpairment = impairment
                openWindow(id: "impairedView")
            }
            .buttonStyle(CustomButtonStyle())
            
            Button("See Red Circle Model") {
                appState.selectedImpairment = impairment
                openWindow(id: "redCircleView")
            }
            .buttonStyle(CustomButtonStyle())
            
            Button("Open Eye Model") {
                appState.shouldShowEyeModel = true
            }


            if impairment == .macularDegeneration {
                Button("Interactive Macular Degeneration Visualization") {
                    experienceWindowToOpen = "macularDegenerationInteractive"
                    showExperienceInstructions = true
                }
                .buttonStyle(CustomButtonStyle())
            }
            
            if impairment == .macularDegeneration {
                Button("Real-World Macular Degeneration Overlay") {
                    experienceWindowToOpen = "macularDegenerationOverlay"
                    showExperienceInstructions = true
                }
                .buttonStyle(CustomButtonStyle())
            }

            if impairment == .glaucoma {
                Button("Interactive Glaucoma Visualization") {
                    experienceWindowToOpen = "glaucomaInteractive"
                    showExperienceInstructions = true
                }
                .buttonStyle(CustomButtonStyle())
            }
            
            if impairment == .glaucoma {
                Button("Real-World Glaucoma Overlay") {
                    appState.selectedImpairment = .glaucoma
                    openWindow(id: "glaucomaLiveOverlay")
                }
                .buttonStyle(CustomButtonStyle())
            }


            if impairment == .cataracts {
                Button("Interactive Cataracts Visualization") {
                    experienceWindowToOpen = "cataractsInteractive"
                    showExperienceInstructions = true
                }
                .buttonStyle(CustomButtonStyle())
            }
            
            if impairment == .diabeticRetinopathy {
                Button("Interactive Diabetic Retinopathy Visualization") {
                    experienceWindowToOpen = "diabeticRetinopathyInteractive"
                    showExperienceInstructions = true
                }
                .buttonStyle(CustomButtonStyle())
            }
            
            if impairment == .diabeticRetinopathy {
                Button("Real-World Diabetic Retinopathy Overlay") {
                    openWindow(id: "diabeticRetinopathyLive")
                }
                .buttonStyle(CustomButtonStyle())
            }


            Spacer()
        }
        .padding()
        .navigationTitle(impairment.rawValue)
        .sheet(isPresented: $showExperienceInstructions) {
            VStack(spacing: 20) {
                Text("How to Use the Simulator")
                    .font(.title2)
                    .bold()

                Text("Use the slider to increase the intensity of the impairment and observe how vision is affected.")
                    .multilineTextAlignment(.center)
                    .padding()

                Button("Start Experience") {
                    showExperienceInstructions = false
                    appState.selectedImpairment = impairment

                    if isImmersiveExperience {
                        Task {
                            await openImmersiveSpace(id: "glaucomaImmersiveExperience")
                            isImmersiveExperience = false
                        }
                    } else if let windowId = experienceWindowToOpen {
                        openWindow(id: windowId)
                    }
                }
                .buttonStyle(CustomButtonStyle())
            }
            .padding()
            .presentationDetents([.medium])
        }
    }
}
