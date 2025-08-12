//import SwiftUI
//import RealityKit
//import RealityKitContent
//
//struct RedCircleView: View {
//    var body: some View {
//        RealityView { content in
//            let redMaterial = SimpleMaterial(color: .red, isMetallic: false)
//            
//            // Use a square plane (will look like a red square)
//            let planeMesh = MeshResource.generatePlane(width: 0.2, depth: 0.2)
//            
//            let circleEntity = ModelEntity(mesh: planeMesh, materials: [redMaterial])
//            circleEntity.position = [0, 0, 0]
//            
//            // Add it to the scene
//            content.add(circleEntity)
//        }
//        .frame(width: 0.2, height: 0.2) // Remove `depth`
//    }
//}
