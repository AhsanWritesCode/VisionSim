import SwiftUI

/// The eye content for a volume.
struct EyeView: View {
    @Environment(ViewModel.self) private var model

    var body: some View {
        ZStack {
            EyeEntityView(configuration: model.eyeConfig)
        }
        .onDisappear {
            model.isShowingEye = false
        }
    }
}
