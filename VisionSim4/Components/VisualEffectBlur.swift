import SwiftUI
import UIKit

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    var intensity: CGFloat = 1.0

    func makeUIView(context: Context) -> UIVisualEffectView {
        let effectView = UIVisualEffectView(effect: nil)
        return effectView
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        let animator = UIViewPropertyAnimator(duration: 1, curve: .linear) {
            uiView.effect = UIBlurEffect(style: blurStyle)
        }
        animator.fractionComplete = intensity
        animator.startAnimation()
    }
}
