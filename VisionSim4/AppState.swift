// AppState

import SwiftUI

class AppState: ObservableObject {
    @Published var selectedImpairment: VisionImpairment = .macularDegeneration
}
