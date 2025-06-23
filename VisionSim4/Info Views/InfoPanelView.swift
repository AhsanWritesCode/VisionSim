import SwiftUI

/// A movable Info Panel that displays details about a selected vision impairment.
struct InfoPanelView: View {
    let impairment: VisionImpairment
    
    // Lets users dismiss this window by tapping done.
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            VStack {
                // Main text block
                VStack(spacing: 25) {
                    Text("About \(impairment.rawValue)")
                        .font(.title2) // Medium title font
                        .bold()
                        .multilineTextAlignment(.center)

                    Text("""
                        Detailed information about \(impairment.rawValue) goes here.
                        """)
                        .font(.body)
                        .multilineTextAlignment(.center) // Center-align all text within this VStack
                        .frame(maxWidth: 450)
                }
            }
            .padding()

            VStack {
                HStack {
                    Spacer()
                    Button("Done") {
                        dismiss()
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
}
