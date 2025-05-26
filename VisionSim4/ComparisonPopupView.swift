//
//  ComparisonPopupView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-26.
//

import SwiftUI

struct ComparisonPopupView: View {
    let title: String
    let images: [String]
    let onClose: (() -> Void)?
    
    @Environment(\.dismiss) private var dismiss
    @State private var currentIndex = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(title)
                    .font(.title2)

                Image(images[currentIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding()

                HStack {
                    Button("Previous") {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }
                    .disabled(currentIndex == 0)

                    Spacer()

                    Button("Next") {
                        if currentIndex < images.count - 1 {
                            currentIndex += 1
                        }
                    }
                    .disabled(currentIndex == images.count - 1)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Close") {
                        dismiss()
                        onClose?()
                    }
                }
            }
        }
    }
}
