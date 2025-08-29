// Main entry point for the app and all window scene registrations.

import SwiftUI

@main
struct VisionSim4App: App {
    // MARK: - App State
    @StateObject private var appState = AppState()
    @State private var immersionStyle: ImmersionStyle = .full // kept around in case immersive spaces return later
    
    // MARK: - Constants
    /// Stable identifiers for additional windows. Using an enum avoids stringly-typed IDs.
    private enum SceneID: String {
        case mainContent
        case infoPanel
        case normalView
        case impairedView
        case macularDegenerationInteractive
        case macularDegenerationOverlay
        case cataractsOverlay
        case glaucomaInteractive
        case glaucomaLiveOverlay
        case cataractsInteractive
        case diabeticRetinopathyInteractive
        case diabeticRetinopathyLive
        case eye
    }
    
    /// Common sizes to keep window layouts consistent across scenes.
    private enum WinSize {
        static let standard = CGSize(width: 800, height: 600)
        static let large    = CGSize(width: 1000, height: 700)
        static let overlay  = CGSize(width: 900, height: 650)
    }
    
    // MARK: - Body
    var body: some Scene {
        // Root tabbed UI for day-to-day navigation.
        WindowGroup {
            TabView {
                IntroView()
                    .tabItem { Label("Intro", systemImage: "info.circle") }
                
                ContentView()
                    .tabItem { Label("Impairments", systemImage: "eye") }
                
                ModelSelectionView()
                    .tabItem { Label("Model", systemImage: "cube.fill") }
                
                CreditsView()
                    .tabItem { Label("Credits", systemImage: "person.3.fill") }
            }
            .environmentObject(appState) // single source of truth for selections/state
        }
        
        // MARK: - Content / Panels
        // Extra window that can mirror/host the main impairment browser.
        WindowGroup(id: SceneID.mainContent.rawValue) {
            ContentView()
                .environmentObject(appState)
        }
        
        // Contextual info panel that follows the currently selected impairment.
        WindowGroup(id: SceneID.infoPanel.rawValue) {
            InfoPanelView(impairment: appState.selectedImpairment)
                .environmentObject(appState)
        }
        
        // MARK: - Interactive Views
        // Image-driven interactive scene variations (preset photos).
        WindowGroup(id: SceneID.macularDegenerationInteractive.rawValue) {
            MacularDegenerationInteractiveView(imageName: "gl_scene_park") // swap default as needed
                .environmentObject(appState)
        }
        
        WindowGroup(id: SceneID.glaucomaInteractive.rawValue) {
            GlaucomaInteractiveView(imageName: "gl_scene_park")
                .environmentObject(appState)
        }
        
        WindowGroup(id: SceneID.cataractsInteractive.rawValue) {
            CataractsInteractiveView(imageName: "cat_scene_park")
                .environmentObject(appState)
        }
        
        WindowGroup(id: SceneID.diabeticRetinopathyInteractive.rawValue) {
            DiabeticRetinopathyInteractiveView(imageName: "dr_scene_park")
                .environmentObject(appState)
        }
        
        // MARK: - Live Overlays
        // Real-time overlay variants (no preset background image).
        WindowGroup(id: SceneID.macularDegenerationOverlay.rawValue) {
            MacularDegenerationLiveView()
                .environmentObject(appState)
        }
        .defaultSize(width: WinSize.standard.width, height: WinSize.standard.height)
        .windowStyle(.plain) // avoid the default chrome for cleaner demos
        
        WindowGroup(id: SceneID.cataractsOverlay.rawValue) {
            CataractsLiveView()
                .environmentObject(appState)
        }
        .defaultSize(width: WinSize.standard.width, height: WinSize.standard.height)
        .windowStyle(.plain)
        
        WindowGroup(id: SceneID.glaucomaLiveOverlay.rawValue) {
            GlaucomaLiveView()
                .environmentObject(appState)
        }
        .windowStyle(.plain)
        
        WindowGroup(id: SceneID.diabeticRetinopathyLive.rawValue) {
            DiabeticRetinopathyLiveView()
                .environmentObject(appState)
        }
        .defaultSize(width: WinSize.large.width, height: WinSize.large.height)
        .windowStyle(.plain)
        
        // MARK: - Models
        // Loads a specific .usdz eye model if provided; falls back to a default.
        WindowGroup(id: SceneID.eye.rawValue, for: String.self) { $modelName in
            Eye(modelName: modelName ?? "EyeModel")
        }
        .windowStyle(.plain)
    }
    
    // MARK: - Helpers
    /// Returns the correct image set for the given impairment and viewing mode.
    /// Keeps asset naming in one place so the rest of the app doesn’t care about filenames.
    private func imageSet(for impairment: VisionImpairment, impaired: Bool) -> [String] {
        switch impairment {
        case .macularDegeneration:
            return impaired
            ? ["md_scene_park_impaired", "md_scene_street_impaired", "md_scene_office_impaired"]
            : ["md_scene_park", "md_scene_street", "md_scene_office"]
            
        case .glaucoma:
            return impaired
            ? ["gl_scene_park_impaired", "gl_scene_street_impaired", "gl_scene_office_impaired"]
            : ["gl_scene_park", "gl_scene_street", "gl_scene_office"]
            
        case .cataracts:
            return impaired
            ? ["cat_scene_park_impaired", "cat_scene_street_impaired", "cat_scene_office_impaired"]
            : ["cat_scene_park", "cat_scene_street", "cat_scene_office"]
            
        case .diabeticRetinopathy:
            return impaired
            ? ["dr_scene_park_impaired", "dr_scene_street_impaired", "dr_scene_office_impaired"]
            : ["dr_scene_park", "dr_scene_street", "dr_scene_office"]
        }
    }
}
