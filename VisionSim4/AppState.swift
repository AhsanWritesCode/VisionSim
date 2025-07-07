// AppState

import SwiftUI

class AppState: ObservableObject {
    @Published var isMainWindowOpen: Bool = true

    @Published var selectedImpairment: VisionImpairment = .macularDegeneration
}

