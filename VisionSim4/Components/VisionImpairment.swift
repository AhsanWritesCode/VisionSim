import Foundation

/// Enumeration of vision impairments
enum VisionImpairment: String, CaseIterable, Identifiable {
    var id: String { rawValue }

    case macularDegeneration = "Macular Degeneration"
    case glaucoma = "Glaucoma"
    case cataracts = "Cataracts"
    case diabeticRetinopathy = "Diabetic Retinopathy"
}
