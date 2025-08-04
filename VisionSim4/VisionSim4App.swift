// VisionSim4App

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

                GuidedWalkthroughView()
                    .tabItem {
                        Label("Walkthrough", systemImage: "book")
                    }

                ContentView()
                    .tabItem {
                        Label("Impairments", systemImage: "eye")
                    }

//                ModelSelectionView()
//                    .tabItem {
//                        Label("Model", systemImage: "cube.fill")
//                    }
                CreditsView()
                    .tabItem {
                        Label("Credits", systemImage: "person.3.fill")
                    }
            }
            .environmentObject(appState)
        }
        
        WindowGroup(id: "mainContent") {
            ContentView()
                .environmentObject(appState)
        }
        
        WindowGroup(id: "infoPanel") {
            InfoPanelView(impairment: appState.selectedImpairment)
              .environmentObject(appState)
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

        WindowGroup(id: "macularDegenerationInteractive") {
            MacularDegenerationInteractiveView(imageName: "gl_scene_park") // or whatever default image
                .environmentObject(appState)

        }
        
        WindowGroup(id: "macularDegenerationOverlay") {
            MacularDegenerationLiveView()
                .environmentObject(appState)
        }
        .defaultSize(width: 800, height: 600)
        .windowStyle(.plain)
        
        WindowGroup(id: "glaucomaInteractive") {
            GlaucomaInteractiveView(imageName: "gl_scene_park")
                .environmentObject(appState)
        }
        
        WindowGroup(id: "glaucomaLiveOverlay") {
            GlaucomaLiveView()
                .environmentObject(appState)
        }
        .windowStyle(.plain)


        
        WindowGroup(id: "cataractsInteractive") {
            CataractsInteractiveView(imageName: "cat_scene_park")
                .environmentObject(appState)
        }
        
//        WindowGroup(id: "modelSelection") {
//            ModelSelectionView()
//                .environmentObject(appState)
//        }
//        .defaultSize(width: 600, height: 400)
//        .windowStyle(.plain)

//        WindowGroup(id: "modelView") {
//            ModelView()
//                .environmentObject(appState)
//        }
//        .windowStyle(.volumetric)
//        .defaultSize(width: 1.0, height: 1.0, depth: 1.0)
        
        WindowGroup(id: "diabeticRetinopathyInteractive") {
            DiabeticRetinopathyInteractiveView(imageName: "dr_scene_park")
                .environmentObject(appState)
        }
        
        WindowGroup(id: "redCircleView") {
            RedCircleView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.3, height: 0.3, depth: 0.1, in: .meters)
        
        WindowGroup(id: "diabeticRetinopathyLive") {
            DiabeticRetinopathyLiveView()
                .environmentObject(appState)
        }
        .defaultSize(width: 1000, height: 700)
        .windowStyle(.plain)
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
        case .diabeticRetinopathy:
            return impaired ? ["dr_scene_park_impaired", "dr_scene_street_impaired", "dr_scene_office_impaired"]
                            : ["dr_scene_park", "dr_scene_street", "dr_scene_office"]
        }
    }
}
