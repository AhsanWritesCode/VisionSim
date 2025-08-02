//import SwiftUI
//import RealityKit
//import RealityKitContent
//
//struct ModelView: View {
//    @EnvironmentObject var appState: AppState
//    @State private var anchor = AnchorEntity()   // local-space anchor inside the volume
//
//    var body: some View {
//        RealityView { content in
//            content.add(anchor)
//            await loadAndPlaceEye()
//        }
//    }
//
//    // MARK: - Load & place
//    private func loadAndPlaceEye() async {
//        let name = appState.selectedEyeModelName.isEmpty ? "EyeModel" : appState.selectedEyeModelName
//
//        do {
//            print("🔎 Trying to load \(name) from RealityKitContent bundle")
//            let entity = try await ModelEntity(named: name, in: realityKitContentBundle)
//
//            // Debug: print bounds
//            let b = entity.visualBounds(relativeTo: nil)
//            print("bounds extents:", b.extents, "center:", b.center)
//
//            // Normalize for visionOS (taken from your ModelManager, simplified)
//            normalizeForVisionOS(entity)
//
//            // VERY IMPORTANT: place INSIDE the volume. Positive z tends to be visible.
//            entity.position = [0, 0, 0.15]
//
//            // Make it interactable (optional but handy)
//            entity.generateCollisionShapes(recursive: true)
//            entity.components.set(InputTargetComponent(allowedInputTypes: .all))
//            entity.components.set(HoverEffectComponent())
//
//            anchor.addChild(entity)
//            print("Added \(name) to anchor")
//
//        } catch {
//            print("Failed to load \(name): \(error)")
//        }
//    }
//
//    private func normalizeForVisionOS(_ entity: ModelEntity) {
//        let bounds = entity.visualBounds(relativeTo: nil)
//        let maxDim = max(bounds.extents.x, bounds.extents.y, bounds.extents.z)
//        guard maxDim > 0 else {
//            print("Invalid bounds, fallback scale 0.1")
//            entity.scale *= 0.1
//            return
//        }
//        let target: Float = 0.25 // 25 cm box
//        let scaleFactor = target / maxDim
//        entity.scale *= scaleFactor
//        print("📏 normalized scale factor:", scaleFactor)
//    }
//}
//
//
////        RealityView { content in
////            if let model = try? await Entity(named: appState.selectedEyeModelName, in: realityKitContentBundle) {
////                model.scale = [0.01, 0.01, 0.01]
////                model.position = [0, 0, -0.5]
////
////                let anchor = AnchorEntity()
////                anchor.addChild(model)
////                content.add(anchor)
////            } else {
////                print("❌ Failed to load model: \(appState.selectedEyeModelName)")
////            }
////        }
