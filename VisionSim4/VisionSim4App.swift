//
//  VisionSim4App.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-15.

import SwiftUI

@main
struct VisionSim4App: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            TabView {
                IntroView()
                    .tabItem {
                        Label("Intro", systemImage: "info.circle")
                    }

                ContentView()
                    .tabItem {
                        Label("Impairments", systemImage: "eye")
                    }
            }
            .environmentObject(appState) // <- inject here
        }

        WindowGroup(id: "normalView") {
            ComparisonPopupView(
                title: "Normal View",
                images: imageSet(for: appState.selectedImpairment, impaired: false),
                onClose: nil
            )
            .environmentObject(appState)
        }

        WindowGroup(id: "impairedView") {
            ComparisonPopupView(
                title: "Impaired View",
                images: imageSet(for: appState.selectedImpairment, impaired: true),
                onClose: nil
            )
            .environmentObject(appState)
        }

        WindowGroup(id: "macularDegenerationExperience") {
            MacularDegenerationExperienceView(imageName: "md_scene_park")
        }
        
        WindowGroup(id: "infoPanel") {
            InfoPanelViewWrapper()
            .environmentObject(appState)
        }
        
        WindowGroup(id: "glaucomaExperience") {
            GlaucomaExperienceView(imageName: "gl_scene_park") // or whatever default image
                .environmentObject(appState)
        }

    }



    
    func imageSet(for impairment: VisionImpairment, impaired: Bool) -> [String] {
        switch impairment {
        case .macularDegeneration:
            return impaired ? ["md_scene_park_impaired", "md_scene_street_impaired", "md_scene_office_impaired"]
                            : ["md_scene_park", "md_scene_street", "md_scene_office"]
        case .glaucoma:
            return impaired ? ["gl_scene_park_impaired", "gl_scene_street_impaired", "gl_scene_office_impaired"]
                            : ["gl_scene_park", "gl_scene_street", "gl_scene_office"]
        case .cataracts:
            return impaired ? ["cat_scene_park_impaired", "cat_scene_street_impaired", "cat_scene_office_impaired"]
                            : ["cat_scene_park", "cat_scene_street", "cat_scene_office"]
        }
    }
}
