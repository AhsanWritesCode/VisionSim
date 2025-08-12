//import Foundation
//import RealityKit
//import RealityKitContent
//
///// An entity that represents an anatomical eye model.
//@MainActor
//class EyeEntity: Entity {
//    
//    // MARK: - Model container
//    private var eyeModel: Entity = Entity()
//    
//    /// Default configuration
//    static let `default` = Configuration()
//    
//    // MARK: - Init
//    required init() {
//        super.init()
//    }
//    
//    required init(configuration: Configuration = EyeEntity.default) async {
//        super.init()
//        
//        guard let eyeModel = try? await Entity(named: configuration.modelName, in: realityKitContentBundle) else {
//            print("❌ Failed to load model named \(configuration.modelName)")
//            return
//        }
//        
//        self.eyeModel = eyeModel
//        self.addChild(eyeModel)
//    }
//}
//
//import RealityKit
//
//extension Entity {
//    func visit(_ action: (Entity) -> Void) {
//        action(self)
//        for child in children {
//            child.visit(action)
//        }
//    }
//}
