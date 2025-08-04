import Foundation
import RealityKit
import RealityKitContent

/// An entity that represents an anatomical eye model.
@MainActor
class EyeEntity: Entity {

    // MARK: - Model container
    private var eyeModel: Entity = Entity()

    /// Default configuration   
    static let `default` = Configuration()

    // MARK: - Init
    required init() {
        super.init()
    }

    required init(configuration: Configuration = EyeEntity.default) async {
        super.init()

        do {
            let eyeModel = try await Entity(named: configuration.modelName, in: realityKitContentBundle)
            self.eyeModel = eyeModel

            // Apply transforms
            eyeModel.setScale(configuration.scale, relativeTo: nil)
            eyeModel.position = configuration.position
            eyeModel.orientation = configuration.rotation

            // 🔧 Optional: force red material to debug invisibility
            let redMaterial = SimpleMaterial(color: .red, isMetallic: false)
            eyeModel.visit { entity in
                if let model = entity as? ModelEntity {
                    model.model?.materials = [redMaterial]
                }
            }

            self.addChild(eyeModel)
        } catch {
            print("❌ Failed to load model named \(configuration.modelName): \(error)")
        }
    }
}

import RealityKit

extension Entity {
    func visit(_ action: (Entity) -> Void) {
        action(self)
        for child in children {
            child.visit(action)
        }
    }
}
