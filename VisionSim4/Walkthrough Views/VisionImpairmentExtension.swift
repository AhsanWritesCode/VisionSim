import Foundation

extension VisionImpairment {
    var overview: String {
        switch self {
        case .glaucoma:
            return """
            Glaucoma is a group of eye diseases that can cause vision loss and blindness by damaging a nerve in the back of your eye called the optic nerve.

            The symptoms can start so slowly that you may not notice them.

            The only way to find out if you have glaucoma is to get a comprehensive dilated eye exam.

            There’s no cure for glaucoma, but early treatment can often stop the damage and protect your vision.
            """

        case .cataracts:
            return "Cataracts occur when the lens of the eye becomes cloudy, leading to blurred vision, faded colors, and difficulty seeing at night. Surgery is often required to restore vision."
        case .macularDegeneration:
            return "Macular degeneration is a disease that affects the central part of the retina, causing central vision loss. It primarily impacts older adults and can be dry or wet in form."
        case .diabeticRetinopathy:
            return "Diabetic retinopathy is a complication of diabetes that affects the eyes. It is caused by damage to the blood vessels of the retina and can lead to vision loss if untreated."
        }
    }

    var symptoms: String {
        switch self {
        case .glaucoma:
            return """
            At first, glaucoma doesn’t usually have any symptoms. That’s why half of people with glaucoma don’t even know they have it.

            Over time, you may slowly lose vision, usually starting with your side (peripheral) vision — especially the part of your vision that’s closest to your nose. Because it happens so slowly, many people can’t tell that their vision is changing at first.

            But as the disease gets worse, you may start to notice that you can’t see things off to the side anymore. Without treatment, glaucoma can eventually cause blindness.
            """
        case .cataracts:
            return "Cloudy or blurry vision, faded colors, glare or halos around lights, poor night vision."
        case .macularDegeneration:
            return "Blurred or reduced central vision, difficulty recognizing faces, straight lines appearing wavy."
        case .diabeticRetinopathy:
            return "Floaters, blurred vision, impaired color vision, dark or empty areas in your vision, vision loss."
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
        case .diabeticRetinopathy:
            return "Blood sugar control, anti-VEGF therapy, laser treatment, and vitrectomy surgery in advanced cases."
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
        case .diabeticRetinopathy:
            return "Diabetes duration, poor blood sugar control, high blood pressure, high cholesterol, pregnancy, tobacco use."
        }
    }
}
