//import SwiftUI
//import RealityKit
//import RealityKitContent
//
//struct Eye: View {
//    let modelName: String
//    @State private var isRotating = 0.0
//
//    var body: some View {
//        Model3D(named: modelName) { eye in
//            eye.resizable()
//               .aspectRatio(contentMode: .fit)
//               .scaleEffect(0.3)
//               .rotation3DEffect(.degrees(isRotating * 2), axis: (x: 15, y: -15, z: 15))
//        } placeholder: {
//            ProgressView()
//        }
//        .toolbar {
//            ToolbarItem(placement: .bottomOrnament) {
//                VStack {
//                    Slider(value: $isRotating, in: 0...359)
//                        .frame(width: 360)
//                        .padding()
//                }
//            }
//        }
//    }
//}


import SwiftUI
import RealityKit
import RealityKitContent

struct Eye: View {
    let modelName: String

    // Persistent state
    @State private var yaw: Double = 0          // around Y axis (left/right)
    @State private var pitch: Double = 0        // around X axis (up/down)
    @State private var baseScale: CGFloat = 1.0 // pinch zoom

    // Gesture state (ephemeral while the gesture is active)
    @GestureState private var dragTranslation: CGSize = .zero
    @GestureState private var pinchFactor: CGFloat = 1.0

    // Tune to taste
    private let degreesPerPoint: Double = 0.4   // sensitivity
    private let minPitch: Double = -85          // avoid flipping
    private let maxPitch: Double =  85

    var body: some View {
        // Live angles while dragging (base + delta)
        let liveYaw   = wrapAngle(yaw + Double(dragTranslation.width)  * degreesPerPoint)
        // Invert dy if you prefer "trackball" feel
        let livePitch = clamp(pitch - Double(dragTranslation.height) * degreesPerPoint,
                              minPitch, maxPitch)

        let rotateGesture =
            DragGesture(minimumDistance: 0)
                .updating($dragTranslation) { value, state, _ in
                    state = value.translation
                }
                .onEnded { value in
                    yaw   = wrapAngle(yaw   + Double(value.translation.width)  * degreesPerPoint)
                    pitch = clamp(pitch - Double(value.translation.height) * degreesPerPoint,
                                  minPitch, maxPitch)
                }

        let zoomGesture =
            MagnificationGesture()
                .updating($pinchFactor) { value, state, _ in
                    state = value
                }
                .onEnded { value in
                    baseScale = min(max(baseScale * value, 0.4), 3.0)
                }

        Model3D(named: modelName) { eye in
            eye.resizable()
               .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
        .contentShape(Rectangle()) // makes the whole area draggable
        .scaleEffect(0.3 * baseScale * pinchFactor)
        .rotation3DEffect(.degrees(livePitch), axis: (x: 1, y: 0, z: 0))
        .rotation3DEffect(.degrees(liveYaw),   axis: (x: 0, y: 1, z: 0))
        .gesture(rotateGesture)
        .simultaneousGesture(zoomGesture)
        .simultaneousGesture(
            TapGesture(count: 2).onEnded {
                // quick reset
                withAnimation(.spring()) { yaw = 0; pitch = 0; baseScale = 1 }
            }
        )
    }
}

// MARK: - Helpers
private func clamp(_ v: Double, _ lo: Double, _ hi: Double) -> Double {
    min(max(v, lo), hi)
}

private func wrapAngle(_ v: Double) -> Double {
    var a = v.truncatingRemainder(dividingBy: 360)
    if a < 0 { a += 360 }
    return a
}
