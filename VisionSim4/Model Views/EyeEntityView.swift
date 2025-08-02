import SwiftUI
import RealityKit
import RealityKitContent


struct EyeEntityView: View {
    var configuration: EyeEntity.Configuration

    var body: some View {
        RealityView { content in
            async let entityResult = Entity(named: "EyeModel", in: realityKitContentBundle)

            if let entity = try? await entityResult {
                entity.setScale(SIMD3<Float>(0.01, 0.01, 0.01), relativeTo: nil)
                entity.position = SIMD3<Float>(0, -0.1, -0.2)
                content.add(entity)
            }
        }
    }
}
