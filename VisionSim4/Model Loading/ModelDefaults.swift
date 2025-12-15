import SwiftUI

struct ModelDefaults {
    var scale: CGFloat = 1.0
    var pitch: Double = 0   // X
    var yaw: Double = 0     // Y
    var roll: Double = 0    // Z
}

func defaults(for name: String) -> ModelDefaults {
    switch name {
    case "LindsayBook":
        // Book authored lying flat
        return .init(scale: 1.0, pitch: -90, yaw: 0, roll: 0)
    default:
        return .init()
    }
}
