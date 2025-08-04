import SwiftUI
import RealityKit
import RealityKitContent

struct EyeEntityView: View {
    var configuration: EyeEntity.Configuration
    var animateUpdates: Bool = false // Optional, in case you add animations

    var body: some View {
        RealityView { content in
            let eyeEntity = await EyeEntity(configuration: configuration)
            content.add(eyeEntity)
        }
    }
}
