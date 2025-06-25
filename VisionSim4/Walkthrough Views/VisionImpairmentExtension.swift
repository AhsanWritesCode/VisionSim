import Foundation

extension VisionImpairment {
    var overview: String {
        switch self {
        case .glaucoma:
            return "Glaucoma is a group of eye conditions that damage the optic nerve, often due to high eye pressure. It causes peripheral vision loss and can lead to blindness if untreated."
        case .cataracts:
            return "Cataracts occur when the lens of the eye becomes cloudy, leading to blurred vision, faded colors, and difficulty seeing at night. Surgery is often required to restore vision."
        case .macularDegeneration:
            return "Macular degeneration is a disease that affects the central part of the retina, causing central vision loss. It primarily impacts older adults and can be dry or wet in form."
        }
    }

    var symptoms: String {
        switch self {
        case .glaucoma:
            return "Gradual peripheral vision loss, tunnel vision, eye pain, and blurred vision."
        case .cataracts:
            return "Cloudy or blurry vision, faded colors, glare or halos around lights, poor night vision."
        case .macularDegeneration:
            return "Blurred or reduced central vision, difficulty recognizing faces, straight lines appearing wavy."
        }
    }

    var treatment: String {
        switch self {
        case .glaucoma:
            return "Prescription eye drops, oral medications, laser therapy, or surgery to reduce eye pressure."
        case .cataracts:
            return "Surgery to replace the cloudy lens with a clear artificial one."
        case .macularDegeneration:
            return "Anti-VEGF injections, laser therapy, dietary supplements for dry form, and vision aids."
        }
    }

    var riskFactors: String {
        switch self {
        case .glaucoma:
            return "Age over 60, family history, high eye pressure, diabetes, and African or Hispanic descent."
        case .cataracts:
            return "Aging, diabetes, smoking, prolonged sun exposure, and alcohol use."
        case .macularDegeneration:
            return "Age over 50, smoking, obesity, high blood pressure, and family history."
        }
    }
}
