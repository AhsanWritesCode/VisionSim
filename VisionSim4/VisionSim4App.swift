//
//  VisionSim4App.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-15.
import SwiftUI

@main
struct VisionSim4App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        WindowGroup(id: "normalView") {
            ComparisonPopupView(
                title: "Normal View",
                images: ["md_scene_park", "md_scene_street", "md_scene_office"], // default
                onClose: nil
            )
        }

        WindowGroup(id: "impairedView") {
            ComparisonPopupView(
                title: "Impaired View",
                images: ["md_scene_park_impaired", "md_scene_street_impaired", "md_scene_office_impaired"],
                onClose: nil
            )
        }
        
        WindowGroup(id: "glaucomaExperience") {
            GlaucomaExperienceView(imageName: "gl_scene_park")
        }

    }
}
