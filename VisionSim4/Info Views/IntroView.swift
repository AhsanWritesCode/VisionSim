// Intro View

import SwiftUI

// The initial "About the App" screen shown under the Intro tab.
// Uses a scrollable and centered layout to present descriptive text, creator, supervisor, and funding information.
struct IntroView: View {
    var body: some View {
        // Use GeometryReader to gain access to the full size of the parent container.
        GeometryReader { geometry in
            // ScrollView allows content to scroll if it doesn't fit vertically.
            ScrollView {
                // VStack to stack all text and dividers vertically with spacing.
                VStack(spacing: 24) {
                    // App title
                    Text("Welcome to Seeing Differently")
                        .font(.largeTitle)
                        .bold()

                    // Brief description of the app
                    Text("This app simulates various vision impairments to help users understand what conditions like macular degeneration, glaucoma, and cataracts look like. In the future, we plan to develop simulations of vision systems beyond just the human eye.")
                        .font(.body)
                }
                
                // Constrain the maximum width to keep text from stretching too wide
                // Maintains aesthetically pleasing look
                .frame(maxWidth: 700)
                
                // Center the VStack inside the GeometryReader’s full width & height
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height,
                    alignment: .center
                )
                
                // Center-align all text within this VStack
                .multilineTextAlignment(.center)
            }
        }
        
        // Apply a blurred/translucent background material behind the scroll content
        .background(.ultraThinMaterial)
        // Let the material fill the entire safe area (even behind the notch/menu)
        .ignoresSafeArea()
    }
}
