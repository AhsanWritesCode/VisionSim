// AppState.swift

import SwiftUI

/// Central app state shared across multiple views and windows.
/// Stores information about which windows are open,
/// what model/impairment is selected, and related flags.
class AppState: ObservableObject {
    /// Tracks if the main content window is currently open
    @Published var isMainWindowOpen: Bool = true

    /// Name of the currently selected 3D eye model
    @Published var selectedEyeModelName: String = "EyeModel" // defaults to NormalEye

    /// The impairment currently selected in the UI
    @Published var selectedImpairment: VisionImpairment = .macularDegeneration

    /// Whether the 3D eye model view should be displayed
    @Published var shouldShowEyeModel: Bool = false
}
