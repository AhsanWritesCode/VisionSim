//
//  ImpairmentDetailView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-27.
//

import SwiftUI

struct ImpairmentDetailView: View {
    @Environment(\.openWindow) private var openWindow
    @EnvironmentObject var appState: AppState

    let impairment: VisionImpairment

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
                    openWindow(id: "macularDegenerationExperience")
                }
                .buttonStyle(CustomButtonStyle())
            }

            Spacer()
        }
        .padding()
        .navigationTitle(impairment.rawValue)
    }
}
