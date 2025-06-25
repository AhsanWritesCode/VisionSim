import SwiftUI

enum StepType: String {
    case overview, symptoms, treatment, riskFactors, interactive
}

struct WalkthroughStep: Identifiable {
    let id = UUID()
    let impairment: VisionImpairment
    let type: StepType
}
