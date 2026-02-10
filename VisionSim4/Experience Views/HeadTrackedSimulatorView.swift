// HeadTrackedSimulatorView.swift
// Provides UI controls for launching head-tracked immersive vision simulations

import SwiftUI
import RealityKit
import RealityKitContent

// MARK: - Head-Tracked Simulator Control View
/// This view provides the UI to launch the different head-tracked immersive simulations
struct HeadTrackedSimulatorView: View {
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @State private var isImmersive = false
    @State private var currentSimulation: String? = nil
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Head-Tracked Vision Simulators")
                .font(.extraLargeTitle)
                .padding()
            
            Text("These simulations use head-tracking to create realistic vision impairment effects that follow your view.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            VStack(spacing: 15) {
                // Glaucoma Full Peripheral Loss
                Button(action: {
                    Task {
                        if isImmersive && currentSimulation == "glaucomaFull" {
                            await dismissImmersiveSpace()
                            isImmersive = false
                            currentSimulation = nil
                        } else {
                            if isImmersive {
                                await dismissImmersiveSpace()
                            }
                            await openImmersiveSpace(id: "glaucomaFullImmersive")
                            isImmersive = true
                            currentSimulation = "glaucomaFull"
                        }
                    }
                }) {
                    Label(
                        (isImmersive && currentSimulation == "glaucomaFull") ? "Exit Simulation" : "Glaucoma: Full Peripheral Loss",
                        systemImage: (isImmersive && currentSimulation == "glaucomaFull") ? "xmark.circle" : "eye.circle"
                    )
                    .font(.title2)
                    .padding()
                    .frame(minWidth: 350)
                }
                .buttonStyle(.borderedProminent)
                .tint((isImmersive && currentSimulation == "glaucomaFull") ? .red : .blue)
                
                // Glaucoma Bottom Vision Loss
                Button(action: {
                    Task {
                        if isImmersive && currentSimulation == "glaucomaBottom" {
                            await dismissImmersiveSpace()
                            isImmersive = false
                            currentSimulation = nil
                        } else {
                            if isImmersive {
                                await dismissImmersiveSpace()
                            }
                            await openImmersiveSpace(id: "glaucomaBottomImmersive")
                            isImmersive = true
                            currentSimulation = "glaucomaBottom"
                        }
                    }
                }) {
                    Label(
                        (isImmersive && currentSimulation == "glaucomaBottom") ? "Exit Simulation" : "Glaucoma: Bottom Vision Loss",
                        systemImage: (isImmersive && currentSimulation == "glaucomaBottom") ? "xmark.circle" : "eye.circle.fill"
                    )
                    .font(.title2)
                    .padding()
                    .frame(minWidth: 350)
                }
                .buttonStyle(.borderedProminent)
                .tint((isImmersive && currentSimulation == "glaucomaBottom") ? .red : .green)
                
                // Macular Degeneration Central Loss
                Button(action: {
                    Task {
                        if isImmersive && currentSimulation == "macular" {
                            await dismissImmersiveSpace()
                            isImmersive = false
                            currentSimulation = nil
                        } else {
                            if isImmersive {
                                await dismissImmersiveSpace()
                            }
                            await openImmersiveSpace(id: "macularDegenerationImmersive")
                            isImmersive = true
                            currentSimulation = "macular"
                        }
                    }
                }) {
                    Label(
                        (isImmersive && currentSimulation == "macular") ? "Exit Simulation" : "Macular Degeneration: Central Loss",
                        systemImage: (isImmersive && currentSimulation == "macular") ? "xmark.circle" : "circle.circle"
                    )
                    .font(.title2)
                    .padding()
                    .frame(minWidth: 350)
                }
                .buttonStyle(.borderedProminent)
                .tint((isImmersive && currentSimulation == "macular") ? .red : .orange)
            }
            
            if isImmersive {
                Text("Look around to experience the vision impairment effect")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .padding(.top)
            }
        }
        .padding()
    }
}

// MARK: - Immersive View Implementations

struct GlaucomaFullImmersiveView: View {
    @State private var severity: Float = 0.5 // 0 = no glaucoma, 1 = severe
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        RealityView { content, attachments in
            let headAnchor = AnchorEntity(.head)
            
            let overlayEntity = createPeripheralBlockers(severity: severity)
            overlayEntity.name = "glaucomaBlockers"
            headAnchor.addChild(overlayEntity)
            
            // Add the HUD attachment
            if let hudAttachment = attachments.entity(for: "severityHUD") {
                hudAttachment.position = SIMD3<Float>(0, -0.3, -0.8) // Below center, in front
                headAnchor.addChild(hudAttachment)
            }
            
            content.add(headAnchor)
        } update: { content, attachments in
            // Update the blockers when severity changes
            if let headAnchor = content.entities.first,
               let oldBlockers = headAnchor.children.first(where: { $0.name == "glaucomaBlockers" }) {
                oldBlockers.removeFromParent()
                let newBlockers = createPeripheralBlockers(severity: severity)
                newBlockers.name = "glaucomaBlockers"
                headAnchor.addChild(newBlockers)
            }
        } attachments: {
            Attachment(id: "severityHUD") {
                VStack(spacing: 15) {
                    Text("Glaucoma Severity")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text("Mild")
                            .font(.caption)
                        
                        Slider(value: $severity, in: 0...1)
                            .frame(width: 250)
                        
                        Text("Severe")
                            .font(.caption)
                    }
                    
                    Text("\(Int(severity * 100))%")
                        .font(.title3)
                        .fontWeight(.bold)
                        .monospacedDigit()
                    
                    Button(action: {
                        openWindow(id: "Eye", value: "book_scaled")
                    }) {
                        Label(
                            "Show Reading Example",
                            systemImage: "book.pages"
                        )
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                }
                .padding(25)
                .glassBackgroundEffect()
            }
        }
    }
    
    func createPeripheralBlockers(severity: Float) -> Entity {
        let entity = Entity()
        
        let distance: Float = 0.5
        let baseSize: Float = 0.8
        
        // Scale the blocker size based on severity
        let planeSize = 0.1 + (baseSize - 0.1) * severity
        
        // Adjust position based on severity
        let offset = 0.9 - (0.3 * severity)
        
        // TOP blocker
        let topMesh = MeshResource.generatePlane(width: 3.0, height: planeSize)
        let topEntity = createBlocker(mesh: topMesh, position: SIMD3<Float>(0, offset, -distance))
        entity.addChild(topEntity)
        
        // BOTTOM blocker
        let bottomMesh = MeshResource.generatePlane(width: 3.0, height: planeSize)
        let bottomEntity = createBlocker(mesh: bottomMesh, position: SIMD3<Float>(0, -offset, -distance))
        entity.addChild(bottomEntity)
        
        // LEFT blocker
        let leftMesh = MeshResource.generatePlane(width: planeSize, height: 2.0)
        let leftEntity = createBlocker(mesh: leftMesh, position: SIMD3<Float>(-offset, 0, -distance))
        entity.addChild(leftEntity)
        
        // RIGHT blocker
        let rightMesh = MeshResource.generatePlane(width: planeSize, height: 2.0)
        let rightEntity = createBlocker(mesh: rightMesh, position: SIMD3<Float>(offset, 0, -distance))
        entity.addChild(rightEntity)
        
        return entity
    }
    
    func createBlocker(mesh: MeshResource, position: SIMD3<Float>) -> ModelEntity {
        var material = UnlitMaterial()
        material.color = .init(tint: .black)
        
        let model = ModelEntity(mesh: mesh, materials: [material])
        model.position = position
        
        return model
    }
}

struct GlaucomaBottomImmersiveView: View {
    var body: some View {
        RealityView { content in
            let headAnchor = AnchorEntity(.head)
            let overlayEntity = createBottomBlocker()
            headAnchor.addChild(overlayEntity)
            content.add(headAnchor)
        }
    }
    
    func createBottomBlocker() -> Entity {
        let entity = Entity()
        
        let distance: Float = 0.5
        let planeSize: Float = 2.0
        let offsetMultiplier: Float = 0.4
        
        // BOTTOM blocker only
        let bottomMesh = MeshResource.generatePlane(width: planeSize * 2, depth: planeSize)
        let bottomEntity = createBlocker(mesh: bottomMesh, position: SIMD3<Float>(0, -planeSize * offsetMultiplier, -distance))
        entity.addChild(bottomEntity)
        
        return entity
    }
    
    func createBlocker(mesh: MeshResource, position: SIMD3<Float>) -> ModelEntity {
        var material = UnlitMaterial()
        material.color = .init(tint: .black)
        
        let model = ModelEntity(mesh: mesh, materials: [material])
        model.position = position
        
        return model
    }
}

struct MacularDegenerationImmersiveView: View {
    var body: some View {
        RealityView { content in
            let headAnchor = AnchorEntity(.head)
            let overlayEntity = createCentralBlocker()
            headAnchor.addChild(overlayEntity)
            content.add(headAnchor)
        }
    }
    
    func createCentralBlocker() -> Entity {
        let entity = Entity()
        
        let distance: Float = 0.5
        let blockerSize: Float = 0.3
        
        // Central blocker for macular degeneration
        let centralMesh = MeshResource.generateSphere(radius: blockerSize / 2)
        let centralEntity = createBlocker(mesh: centralMesh, position: SIMD3<Float>(0, 0, -distance))
        
        entity.addChild(centralEntity)
        
        return entity
    }
    
    func createBlocker(mesh: MeshResource, position: SIMD3<Float>) -> ModelEntity {
        var material = UnlitMaterial()
        material.color = .init(tint: .black)
        
        let model = ModelEntity(mesh: mesh, materials: [material])
        model.position = position
        
        return model
    }
}

#Preview {
    HeadTrackedSimulatorView()
}
