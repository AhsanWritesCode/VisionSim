import SwiftUI
import RealityKit
import RealityKitContent

/// Simple 3D eye viewer with drag-to-rotate, pinch-to-zoom, and double-tap reset.
struct Eye: View {
    let modelName: String

    // Persistent state
    @State private var yaw: Double = 0          // rotate around Y (left/right)
    @State private var pitch: Double = 0        // rotate around X (up/down)
    @State private var baseScale: CGFloat = 1.0 // pinch zoom base

    // Gesture state (temporary while the gesture is active)
    @GestureState private var dragTranslation: CGSize = .zero
    @GestureState private var pinchFactor: CGFloat = 1.0

    // Tuning
    private let degreesPerPoint: Double = 0.4   // rotation sensitivity
    private let minPitch: Double = -85          // keep model from flipping over
    private let maxPitch: Double =  85

    var body: some View {
        // Live angles while dragging (stored base + current gesture delta)
        let liveYaw = wrapAngle(yaw + Double(dragTranslation.width) * degreesPerPoint)
        // Invert dy for a “trackball” feel
        let livePitch = clamp(pitch - Double(dragTranslation.height) * degreesPerPoint,
                              minPitch, maxPitch)

        // Drag = rotation
        let rotateGesture =
            DragGesture(minimumDistance: 0)
                .updating($dragTranslation) { value, state, _ in
                    state = value.translation
                }
                .onEnded { value in
                    yaw = wrapAngle(yaw + Double(value.translation.width) * degreesPerPoint)
                    pitch = clamp(pitch - Double(value.translation.height) * degreesPerPoint,
                                  minPitch, maxPitch)
                }

        // Pinch = zoom
        let zoomGesture =
            MagnificationGesture()
                .updating($pinchFactor) { value, state, _ in
                    state = value
                }
                .onEnded { value in
                    // Clamp to a sensible range so it doesn’t disappear or explode
                    baseScale = min(max(baseScale * value, 0.4), 3.0)
                }

        Model3D(named: modelName) { eye in
            eye.resizable()
               .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
        .contentShape(Rectangle()) // make the whole area hit-testable for gestures
        .scaleEffect(0.3 * baseScale * pinchFactor)
        .rotation3DEffect(.degrees(livePitch), axis: (x: 1, y: 0, z: 0))
        .rotation3DEffect(.degrees(liveYaw),   axis: (x: 0, y: 1, z: 0))
        .gesture(rotateGesture)
        .simultaneousGesture(zoomGesture)
        .simultaneousGesture(
            // Double-tap to quickly reset orientation and zoom
            TapGesture(count: 2).onEnded {
                withAnimation(.spring()) { yaw = 0; pitch = 0; baseScale = 1 }
            }
        )
    }
}

// MARK: - Helpers

/// Clamp a value to a closed range.
private func clamp(_ v: Double, _ lo: Double, _ hi: Double) -> Double {
    min(max(v, lo), hi)
}

/// Wrap an angle to [0, 360).
private func wrapAngle(_ v: Double) -> Double {
    var a = v.truncatingRemainder(dividingBy: 360)
    if a < 0 { a += 360 }
    return a
}
