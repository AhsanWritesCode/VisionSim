import Foundation

/// Represents the different types of vision impairments
/// that the app can simulate or provide information about.
enum VisionImpairment: String, CaseIterable, Identifiable {
    // Use the raw string value as a stable ID for lists, etc.
    var id: String { rawValue }

    // Specific impairment cases with readable string values.
    case macularDegeneration = "Macular Degeneration"
    case glaucoma = "Glaucoma"
    case cataracts = "Cataracts"
    case diabeticRetinopathy = "Diabetic Retinopathy"
}
