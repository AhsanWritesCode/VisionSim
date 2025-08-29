import Foundation

/// Extend VisionImpairment with descriptive properties
/// so each case can supply its own content directly.
/// This keeps the InfoPanelView and similar UI components clean.
extension VisionImpairment {
    
    /// General description of the impairment, covering what it is,
    /// different types (if applicable), and how it impacts vision.
    var overview: String {
        switch self {
        case .glaucoma:
            return """
            Glaucoma is the name of a group of eye diseases that damage the optic nerve. 
            
            The most common type of glaucoma is open-angle glaucoma, but there are three other major types: closed-angle glaucoma, congenital glaucoma, and secondary glaucoma.
            
            If left untreated, it can lead to significant loss of peripheral vision and eventual blindness. Often described as the silent thief of sight, its symptoms are initially imperceptible as the peripheral vision loss begins close to your nose. As a result, the only way to find out if you have glaucoma in its early stages is to get a comprehensive dilated eye exam.

            If glaucoma is treated early, the damage to an individual's eye can be minimized and their vision can be saved. Unfortunately, there is no cure for glaucoma. 
            """

        case .cataracts:
            return "Cataracts occur when the lens of the eye becomes cloudy, leading to blurred vision, faded colors, and difficulty seeing at night. Surgery is often required to restore vision."
            
        case .macularDegeneration:
            return """
            Age-related macular degeneration (AMD) is a vision impairment which blurs an individual's central vision. It's caused by damage to the macula as a result of aging (hence the name). The macula is part of the retina, and controls central vision. 
            
            There are two types of AMD: dry AMD and wet AMD. Dry AMD progresses through early, intermediate, and late stages, while wet AMD is always considered late stage AMD. Dry AMD can turn into wet AMD at any stage. 
            
            While AMD doesn't cause complete blindness, it can significantly decrease quality of life for an individual. Some things that are difficult for individuals that have AMD include reading signs, making out faces, reading, driving, and cooking. 
            """
            
        case .diabeticRetinopathy:
            return """
            Diabetic retinopathy is a complication of diabetes that affects the blood vessels of the retina. Over time, high blood sugar levels can damage these vessels, causing them to swell, leak, or close off entirely. New abnormal vessels may also grow on the retina. 
            
            The damage disrupts normal vision and can cause progressive vision loss if untreated. Diabetic retinopathy often develops in both eyes.
            """
        }
    }

    /// Typical symptoms associated with each impairment.
    var symptoms: String {
        switch self {
        case .glaucoma:
            return """
            In its early stages, individuals with glaucoma don't experience any symptoms. The CDC states that, for this reason, 50% of people with glaucoma don't know they have it.  

            Over time, vision loss begins to occur, starting with an individual's peripheral vision (especially the vision closest to the nose). 
            
            Without treatment, glaucoma eventually leads to complete blindness. 
            """
        case .cataracts:
            return "Cloudy or blurry vision, faded colors, glare or halos around lights, poor night vision."
        case .macularDegeneration:
            return "Blurred or reduced central vision, difficulty recognizing faces, straight lines appearing wavy."
        case .diabeticRetinopathy:
            return "Floaters, blurred vision, impaired color vision, dark or empty areas in your vision, vision loss."
        }
    }

    /// Common treatments or management strategies.
    var treatment: String {
        switch self {
        case .glaucoma:
            return "Prescription eye drops, oral medications, laser therapy, or surgery to reduce eye pressure."
        case .cataracts:
            return "In its early stages, cataracts can be managed with brighter lighting, glasses, or other lifestyle adjustments. The definitive treatment is surgery, in which the cloudy lens is replaced with an artificial intraocular lens (IOL)."
        case .macularDegeneration:
            return "There is no treatment for early or late-stage dry AMD. However, dietary supplements may slow the progression of intermediate dry AMD. For wet AMD, anti-VEGF drugs and photodynamic therapy can help prevent further vision loss."
        case .diabeticRetinopathy:
            return "Blood sugar control is the first line of defense. Additional treatments include anti-VEGF injections, laser therapy, and vitrectomy surgery in advanced cases."
        }
    }

    /// Risk factors that increase the likelihood of developing the impairment.
    var riskFactors: String {
        switch self {
        case .glaucoma:
            return "Risk is higher for individuals over 60; those over 40 who are African American are also more at risk. A family history of glaucoma significantly increases the likelihood of developing it."
        case .cataracts:
            return "Aging, diabetes, smoking, prolonged sun exposure, and alcohol use."
        case .macularDegeneration:
            return "Risk increases with age, especially over 55. Other factors include smoking, being Caucasian, and having a family history of AMD."
        case .diabeticRetinopathy:
            return "Duration of diabetes, poor blood sugar control, high blood pressure, high cholesterol, pregnancy, and tobacco use."
        }
    }
}
