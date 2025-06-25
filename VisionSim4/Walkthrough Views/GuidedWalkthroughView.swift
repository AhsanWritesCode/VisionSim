//  Guided Walkthrough View

import SwiftUI

struct GuidedWalkthroughView: View {
    @State private var currentIndex = 0
    @EnvironmentObject var appState: AppState

    private let impairments = VisionImpairment.allCases

    var body: some View {
        VStack(spacing: 20) {
            Text("Guided Walkthrough")
                .font(.largeTitle)
                .bold()

            TabView(selection: $currentIndex) {
                ForEach(impairments.indices, id: \.self) { index in
                    WalkthroughStepView(impairment: impairments[index])
                        .tag(index)
                        .padding()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))

            HStack {
                Button("Previous") {
                    if currentIndex > 0 { currentIndex -= 1 }
                }
                .disabled(currentIndex == 0)

                Spacer()

                Button("Next") {
                    if currentIndex < impairments.count - 1 { currentIndex += 1 }
                }
                .disabled(currentIndex == impairments.count - 1)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
