import Foundation

extension VisionImpairment {
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
            Age-related macular degeneration (AMD) is a vision impairment which blurs an individual's central vision. It's caused by damage to the macula as a result of aging (hence the name). The macula is part of the retina, and controls central vision. 
            
            There are two types of AMD: dry AMD and wet AMD. Dry AMD progresses through early, intermediate, and late stages, while wet AMD is always considered late stage AMD. Dry AMD can turn into wet AMD at any stage. 
            
            While AMD doesn't cause complete blindness, it can significantly decrease quality of life for an individual. Some things that are difficult for individuals that have AMD include reading signs, making out faces, reading, driving, and cooking. 
            """
        }
    }

    var symptoms: String {
        switch self {
        case .glaucoma:
            return """
            In its early stages, individuals with glacuoma don't experience any symptoms. The CDC states that, for this reason, 50% of people with glaucoma don't know they have it.  

            Over time, vision loss begins to occur, beginning with an individual's peripheral vision (especially the vision closest to an individual's nose). 
            
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

    var treatment: String {
        switch self {
        case .glaucoma:
            return "Prescription eye drops, oral medications, laser therapy, or surgery to reduce eye pressure."
        case .cataracts:
            return "In its early stages, cataracts can be treated by simply using brighter lights, wearing glasses, and making other lifestyle changes. Cataracts can also be treated effectively with surgery; in the procedure, the clouded lens is replaced with an artificial lens called an intraocular lens (IOL)."
        case .macularDegeneration:
            return "There is no treatment for early or late-stage dry AMD. However, dietary supplements may be able to slow the progression of intermediate dry AMD to late stage dry AMD. For wet AMD specifically, anti-VEGF drugs and photodynamic therapy may be able to prevent further vision loss."
        case .diabeticRetinopathy:
            return "Blood sugar control, anti-VEGF therapy, laser treatment, and vitrectomy surgery in advanced cases."
        }
    }

    var riskFactors: String {
        switch self {
        case .glaucoma:
            return "The risk for glaucoma is higher in individuals over the age of 60; those that are over the age of 40 and African American are also at higher risk. Having a family history of the condition also increases an individual's risk of developing it themselves."
        case .cataracts:
            return "Aging, diabetes, smoking, prolonged sun exposure, and alcohol use."
        case .macularDegeneration:
            return "The risk for macular degeneration increases as an individual ages; those that are over the age of 55 are more likely to have AMD. Other risk factors include smoking, being caucasian, and having a family history of the condition."
        case .diabeticRetinopathy:
            return "Diabetes duration, poor blood sugar control, high blood pressure, high cholesterol, pregnancy, tobacco use."
        }
    }
}
