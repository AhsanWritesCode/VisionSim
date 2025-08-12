//import SwiftUI
//import RealityKit
//import RealityKitContent
//
///// The model of the Eye.
//struct Eye: View {
//    var eyeConfiguration: EyeEntity.Configuration = .normalEye
//    var animateUpdates: Bool = false
//    var axCustomActionHandler: ((_: AccessibilityEvents.CustomAction) -> Void)? = nil
//
//    /// The Eye entity that the view creates and stores for updates.
//    @State private var eyeEntity: EyeEntity?
//
//    var body: some View {
//        RealityView { content in
//            // Create the EyeEntity with the current configuration.
//            let eyeEntity = await EyeEntity(configuration: eyeConfiguration)
//            content.add(eyeEntity)
//
//            // Accessibility support
//            if let axCustomActionHandler {
//                _ = content.subscribe(
//                    to: AccessibilityEvents.CustomAction.self,
//                    on: nil,
//                    componentType: nil,
//                    axCustomActionHandler)
//            }
//
//            // Store the entity for later configuration updates
//            self.eyeEntity = eyeEntity
//
//        } update: { content in
//            // Reapply configuration on changes (if update support added to EyeEntity)
//            // Example if you make EyeEntity.update(...) in the future:
//            // eyeEntity?.update(configuration: eyeConfiguration, animateUpdates: animateUpdates)
//        }
//    }
//}
//
