//
//  ComparisonPopupView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-26.
//  Updated: “Previous”/“Next” on left/right edges.
//

import SwiftUI

struct ComparisonPopupView: View {
    let title: String             // e.g. "Normal View" or "Impaired View"
    let images: [String]          // array of image names
    let onClose: (() -> Void)?    // callback when closed

    @Environment(\.dismiss) private var dismiss
    @State private var currentIndex = 0

    var body: some View {
        ZStack {
            // -------------------------------------------------------
            // 1) BACKGROUND: Full-screen image
            // -------------------------------------------------------
            Group {
                if images.indices.contains(currentIndex) {
                    Image(images[currentIndex])
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                } else {
                    Color.black
                }
            }
            .ignoresSafeArea()

            // -------------------------------------------------------
            // 2) TOP BAR: Title + “Close” button
            // -------------------------------------------------------
            VStack(spacing: 0) {
                HStack {
                    Text(title)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.leading, 20)

                    Spacer()

                    Button {
                        dismiss()
                        onClose?()
                    } label: {
                        Text("Close")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(8)
                    }
                    .padding(.trailing, 20)
                }
                .padding(.top, 30)   // leave room for Vision Pro UI
                .padding(.bottom, 10)
                .background(Color.black.opacity(0.4))

                Spacer()
            }

            // -------------------------------------------------------
            // 3) LEFT / RIGHT ARROW BUTTONS
            // -------------------------------------------------------
            HStack {
                // Left (Previous) button
                Button {
                    if currentIndex > 0 {
                        currentIndex -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(currentIndex > 0 ? Color.white : Color.gray.opacity(0.6))
                        .padding(20)
                        .background(
                            Color.black.opacity(currentIndex > 0 ? 0.5 : 0.2)
                        )
                        .clipShape(Circle())
                }
                .disabled(currentIndex == 0)
                .padding(.leading, 20)

                Spacer()

                // Right (Next) button
                Button {
                    if currentIndex < images.count - 1 {
                        currentIndex += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor((currentIndex < images.count - 1) ? Color.white : Color.gray.opacity(0.6))
                        .padding(20)
                        .background(
                            Color.black.opacity((currentIndex < images.count - 1) ? 0.5 : 0.2)
                        )
                        .clipShape(Circle())
                }
                .disabled(currentIndex >= images.count - 1)
                .padding(.trailing, 20)
            }
            .frame(maxHeight: .infinity)   // stretch vertically
            .padding(.vertical, 0)         // no extra vertical padding
        }
    }
}

#if DEBUG
struct ComparisonPopupView_Previews: PreviewProvider {
    static var previews: some View {
        ComparisonPopupView(
            title: "Normal View",
            images: ["scene_park", "scene_traffic", "scene_office"],
            onClose: { print("closed") }
        )
    }
}
#endif
