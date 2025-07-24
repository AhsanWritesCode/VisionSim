// AppState

import SwiftUI

class AppState: ObservableObject {
    @Published var isMainWindowOpen: Bool = true
    @Published var selectedEyeModelName: String = "EyeModel" // Default to NormalEye
    @Published var selectedImpairment: VisionImpairment = .macularDegeneration
}

