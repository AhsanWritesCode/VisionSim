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
                
                // Cataracts Clouded Vision
                Button(action: {
                    Task {
                        if isImmersive && currentSimulation == "cataracts" {
                            await dismissImmersiveSpace()
                            isImmersive = false
                            currentSimulation = nil
                        } else {
                            if isImmersive {
                                await dismissImmersiveSpace()
                            }
                            await openImmersiveSpace(id: "cataractsImmersive")
                            isImmersive = true
                            currentSimulation = "cataracts"
                        }
                    }
                }) {
                    Label(
                        (isImmersive && currentSimulation == "cataracts") ? "Exit Simulation" : "Cataracts: Clouded Vision",
                        systemImage: (isImmersive && currentSimulation == "cataracts") ? "xmark.circle" : "cloud.fill"
                    )
                    .font(.title2)
                    .padding()
                    .frame(minWidth: 350)
                }
                .buttonStyle(.borderedProminent)
                .tint((isImmersive && currentSimulation == "cataracts") ? .red : .purple)
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
    @State private var showBook: Bool = false
    @State private var bookEntity: Entity?
    
    var body: some View {
        RealityView { content, attachments in
            let headAnchor = AnchorEntity(.head)
            
            let overlayEntity = createPeripheralBlockers(severity: severity)
            overlayEntity.name = "glaucomaBlockers"
            headAnchor.addChild(overlayEntity)
            
            // Add the HUD attachment
            if let hudAttachment = attachments.entity(for: "severityHUD") {
                hudAttachment.position = SIMD3<Float>(0, -0.3, -0.8)
                headAnchor.addChild(hudAttachment)
            }
            
            content.add(headAnchor)
            
            // Load book entity on initialization
            Task { @MainActor in
                do {
                    let bookScene = try await Entity(named: "book_scaled", in: realityKitContentBundle)
                    bookScene.name = "bookModel"
                    bookScene.components.set(InputTargetComponent())
                    bookScene.components.set(CollisionComponent(shapes: [.generateBox(width: 0.2, height: 0.3, depth: 0.01)]))
                    
                    let worldAnchor = AnchorEntity(.head)
                    worldAnchor.name = "bookWorldAnchor"
                    worldAnchor.position = SIMD3<Float>(0, 0, -0.6)
                    bookScene.position = .zero
                    worldAnchor.addChild(bookScene)
                    
                    bookEntity = worldAnchor
                } catch {
                    print("Failed to load book model: \(error)")
                }
            }
        } update: { content, attachments in
            // Update the blockers when severity changes
            if let headAnchor = content.entities.first,
               let oldBlockers = headAnchor.children.first(where: { $0.name == "glaucomaBlockers" }) {
                oldBlockers.removeFromParent()
                let newBlockers = createPeripheralBlockers(severity: severity)
                newBlockers.name = "glaucomaBlockers"
                headAnchor.addChild(newBlockers)
            }
            
            // Update book visibility
            let bookExists = content.entities.contains { $0.name == "bookWorldAnchor" }
            
            if showBook && !bookExists {
                // Add the book if it's loaded
                if let book = bookEntity {
                    content.add(book)
                }
            } else if !showBook && bookExists {
                if let bookAnchor = content.entities.first(where: { $0.name == "bookWorldAnchor" }) {
                    content.remove(bookAnchor)
                }
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
                        showBook.toggle()
                    }) {
                        Label(
                            showBook ? "Hide Book" : "Show Reading Example",
                            systemImage: showBook ? "book.closed" : "book.pages"
                        )
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                    }
                    .buttonStyle(.bordered)
                    .tint(showBook ? .red : .blue)
                    
                    if showBook {
                        Text("Pinch to rotate & scale")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(25)
                .glassBackgroundEffect()
            }
        }
        .gesture(
            DragGesture()
                .targetedToAnyEntity()
                .onChanged { value in
                    value.entity.position = value.convert(value.location3D, from: .local, to: value.entity.parent!)
                }
        )
        .gesture(
            RotateGesture3D()
                .targetedToAnyEntity()
                .onChanged { value in
                    let rotation = simd_quatf(angle: Float(value.rotation.angle.radians),
                                             axis: SIMD3<Float>(Float(value.rotation.axis.x),
                                                               Float(value.rotation.axis.y),
                                                               Float(value.rotation.axis.z)))
                    value.entity.orientation = rotation * value.entity.orientation
                }
        )
        .gesture(
            MagnifyGesture()
                .targetedToAnyEntity()
                .onChanged { value in
                    value.entity.scale *= Float(value.magnification)
                }
        )
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
    @State private var severity: Float = 0.5 // 0 = no degeneration, 1 = severe
    
    var body: some View {
        RealityView { content, attachments in
            let headAnchor = AnchorEntity(.head)
            
            let overlayEntity = createCentralBlocker(severity: severity)
            overlayEntity.name = "macularBlocker"
            headAnchor.addChild(overlayEntity)
            
            // Add the HUD attachment
            if let hudAttachment = attachments.entity(for: "severityHUD") {
                hudAttachment.position = SIMD3<Float>(0, -0.3, -0.8)
                headAnchor.addChild(hudAttachment)
            }
            
            content.add(headAnchor)
        } update: { content, attachments in
            // Update the blocker when severity changes
            if let headAnchor = content.entities.first,
               let oldBlocker = headAnchor.children.first(where: { $0.name == "macularBlocker" }) {
                oldBlocker.removeFromParent()
                let newBlocker = createCentralBlocker(severity: severity)
                newBlocker.name = "macularBlocker"
                headAnchor.addChild(newBlocker)
            }
        } attachments: {
            Attachment(id: "severityHUD") {
                VStack(spacing: 15) {
                    Text("Macular Degeneration Severity")
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
                }
                .padding(25)
                .glassBackgroundEffect()
            }
        }
    }
    
    func createCentralBlocker(severity: Float) -> Entity {
        let entity = Entity()
        
        let distance: Float = 0.5
        let minBlockerSize: Float = 0.05
        let maxBlockerSize: Float = 0.4
        
        // Scale the blocker size based on severity
        let blockerSize = minBlockerSize + (maxBlockerSize - minBlockerSize) * severity
        
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

struct CataractsImmersiveView: View {
    @State private var severity: Float = 0.5 // 0 = clear, 1 = severe cloudiness
    
    var body: some View {
        RealityView { content, attachments in
            let headAnchor = AnchorEntity(.head)
            
            let overlayEntity = createCataractOverlay(severity: severity)
            overlayEntity.name = "cataractOverlay"
            headAnchor.addChild(overlayEntity)
            
            // Add the HUD attachment
            if let hudAttachment = attachments.entity(for: "severityHUD") {
                hudAttachment.position = SIMD3<Float>(0, -0.3, -0.8)
                headAnchor.addChild(hudAttachment)
            }
            
            content.add(headAnchor)
        } update: { content, attachments in
            // Update the overlay when severity changes
            if let headAnchor = content.entities.first,
               let oldOverlay = headAnchor.children.first(where: { $0.name == "cataractOverlay" }) {
                oldOverlay.removeFromParent()
                let newOverlay = createCataractOverlay(severity: severity)
                newOverlay.name = "cataractOverlay"
                headAnchor.addChild(newOverlay)
            }
        } attachments: {
            Attachment(id: "severityHUD") {
                VStack(spacing: 15) {
                    Text("Cataract Severity")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text("Clear")
                            .font(.caption)
                        
                        Slider(value: $severity, in: 0...1)
                            .frame(width: 250)
                        
                        Text("Cloudy")
                            .font(.caption)
                    }
                    
                    Text("\(Int(severity * 100))%")
                        .font(.title3)
                        .fontWeight(.bold)
                        .monospacedDigit()
                    
                    Text("Cataracts cause clouding of the lens, creating a foggy appearance")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 280)
                }
                .padding(25)
                .glassBackgroundEffect()
            }
        }
    }
    
    func createCataractOverlay(severity: Float) -> Entity {
        let entity = Entity()
        
        let distance: Float = 0.25
        let planeSize: Float = 3.0
        
        // Create a semi-transparent yellowish-white overlay to simulate cloudiness
        let mesh = MeshResource.generatePlane(width: planeSize, height: planeSize)
        
        var material = UnlitMaterial()
        material.blending = .transparent(opacity: 1.0)
        
        // Calculate opacity based on severity (0.0 to 0.7 max for visibility)
        let maxOpacity: Float = 0.7
        let opacity = severity * maxOpacity
        
        // Yellowish tint for cataracts (more yellow as severity increases)
        let yellowTint = 0.15 * severity
        let tintColor = UIColor(
            red: 1.0,
            green: CGFloat(1.0 - yellowTint),
            blue: CGFloat(1.0 - yellowTint * 1.5),
            alpha: CGFloat(opacity)
        )
        
        material.color = .init(tint: tintColor, texture: nil)
        
        // Create the main overlay
        let overlayEntity = ModelEntity(mesh: mesh, materials: [material])
        overlayEntity.position = SIMD3<Float>(0, 0, -distance)
        entity.addChild(overlayEntity)
        
        // Add a second, slightly offset layer for depth/haze effect
        if severity > 0.2 {
            var secondMaterial = UnlitMaterial()
            secondMaterial.blending = .transparent(opacity: 1.0)
            let secondOpacity = opacity * 0.4
            let secondColor = UIColor(
                red: 1.0,
                green: CGFloat(1.0 - yellowTint * 0.5),
                blue: CGFloat(1.0 - yellowTint),
                alpha: CGFloat(secondOpacity)
            )
            secondMaterial.color = .init(tint: secondColor, texture: nil)
            
            let secondLayer = ModelEntity(mesh: mesh, materials: [secondMaterial])
            secondLayer.position = SIMD3<Float>(0, 0, -distance - 0.08)
            secondLayer.scale = SIMD3<Float>(repeating: 1.05)
            entity.addChild(secondLayer)
        }
        
        // Add scattered "cloudy spots" for moderate to severe cataracts
        if severity > 0.4 {
            addCloudySpots(to: entity, severity: severity, distance: distance)
        }
        
        return entity
    }
    
    func addCloudySpots(to entity: Entity, severity: Float, distance: Float) {
        // Create several small cloudy spots scattered across the view
        let spotCount = Int(4 + (severity - 0.4) * 12) // 4-11 spots depending on severity
        
        for i in 0..<spotCount {
            let angle = Float(i) * (2.0 * .pi / Float(spotCount)) + Float.random(in: -0.3...0.3)
            let radius: Float = 0.2 + Float.random(in: -0.05...0.3)
            
            let x = cos(angle) * radius
            let y = sin(angle) * radius
            
            let spotSize: Float = 0.06 + Float.random(in: 0...0.08) * severity
            let spotMesh = MeshResource.generateSphere(radius: spotSize)
            
            var spotMaterial = UnlitMaterial()
            spotMaterial.blending = .transparent(opacity: 1.0)
            let spotOpacity = 0.2 + (severity - 0.4) * 0.8
            let spotColor = UIColor(
                red: 1.0,
                green: CGFloat(0.95 - 0.1 * severity),
                blue: CGFloat(0.85 - 0.2 * severity),
                alpha: CGFloat(spotOpacity)
            )
            spotMaterial.color = .init(tint: spotColor, texture: nil)
            
            let spotEntity = ModelEntity(mesh: spotMesh, materials: [spotMaterial])
            spotEntity.position = SIMD3<Float>(x, y, -distance + 0.03)
            
            entity.addChild(spotEntity)
        }
    }
}

#Preview {
    HeadTrackedSimulatorView()
}
