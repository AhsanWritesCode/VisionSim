//
//  ImpairmentDetailView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-27.
//

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
        }
    }

    var impairedImages: [String] {
        switch impairment {
        case .macularDegeneration: return ["md_scene_park_impaired", "md_scene_street_impaired", "md_scene_office_impaired"]
        case .glaucoma: return ["gl_scene_park_impaired", "gl_scene_street_impaired", "gl_scene_office_impaired"]
        case .cataracts: return ["cat_scene_park_impaired", "cat_scene_street_impaired", "cat_scene_office_impaired"]
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

            if impairment == .macularDegeneration {
                Button("Experience Macular Degeneration") {
                    experienceWindowToOpen = "macularDegenerationExperience"
                    showExperienceInstructions = true
                }
                .buttonStyle(CustomButtonStyle())
            }

            if impairment == .glaucoma {
                Button("Experience Glaucoma") {
                    experienceWindowToOpen = "glaucomaExperience"
                    showExperienceInstructions = true
                }
                .buttonStyle(CustomButtonStyle())

//                Button("Start Immersive Glaucoma Experience") {
//                    isImmersiveExperience = true
//                    showExperienceInstructions = true
//                }
//                .buttonStyle(CustomButtonStyle())
            }

            if impairment == .cataracts {
                Button("Experience Cataracts") {
                    experienceWindowToOpen = "cataractsExperience"
                    showExperienceInstructions = true
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
