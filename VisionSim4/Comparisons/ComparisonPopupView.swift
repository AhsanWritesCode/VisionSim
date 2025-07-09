import SwiftUI

struct ComparisonPopupView: View {
    let title: String
    let images: [String]
    let onClose: (() -> Void)?

    @Environment(\.dismiss) private var dismiss
    @State private var currentIndex = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Fullscreen Image
                Group {
                    if images.indices.contains(currentIndex) {
                        Image(images[currentIndex])
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    } else {
                        Color.black
                    }
                }
                .ignoresSafeArea()

 

                // Back button - placed independently in top-left corner
                VStack {
                    HStack {
                        BackToHomeButton()
                            .padding(.top, geometry.safeAreaInsets.top + 12)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    Spacer()
                }
                .ignoresSafeArea(.all, edges: .top)

                // Arrows
                HStack {
                    Button {
                        if currentIndex > 0 { currentIndex -= 1 }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 30, weight: .semibold))
                            .padding(20)
                            .background(Color.black.opacity(currentIndex > 0 ? 0.5 : 0.2))
                            .clipShape(Circle())
                    }
                    .disabled(currentIndex == 0)
                    .padding(.leading, 20)

                    Spacer()

                    Button {
                        if currentIndex < images.count - 1 { currentIndex += 1 }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(currentIndex < images.count - 1 ? .white : Color.gray.opacity(0.6))
                            .padding(20)
                            .background(Color.black.opacity(currentIndex < images.count - 1 ? 0.5 : 0.2))
                            .clipShape(Circle())
                    }
                    .disabled(currentIndex >= images.count - 1)
                    .padding(.trailing, 20)
                }
                .frame(maxHeight: .infinity)
            }
        }
    }
}
