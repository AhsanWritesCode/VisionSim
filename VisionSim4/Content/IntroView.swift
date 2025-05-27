//
//  IntroView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-27.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    Text("Welcome to VisionSim")
                        .font(.largeTitle)
                        .bold()

                    Text("This app simulates various vision impairments to help users understand what conditions like macular degeneration, glaucoma, and cataracts look like.")
                        .font(.body)

                    Divider()

                    Text("Created by")
                        .font(.headline)
                    Text("Ahsan Tariq")

                    Divider()

                    Text("Supervised by")
                        .font(.headline)
                    Text("Dr. Christian Jacob")

                    Divider()

                    Text("Funding")
                        .font(.headline)
                    Text("This research project was supported by Alberta Innovates.")
                }
                .padding(40)
                .frame(maxWidth: 700)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .multilineTextAlignment(.center) // 👈 centers all the text content
            }
        }
        .background(.ultraThinMaterial)
        .ignoresSafeArea()
    }
}

#Preview {
    IntroView()
}
