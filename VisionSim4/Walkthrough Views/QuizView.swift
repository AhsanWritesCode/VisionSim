import SwiftUI

struct QuizView: View {
    let question: QuizQuestion
    @State private var selectedIndex: Int? = nil
    @State private var isAnswered = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Quiz")
                .font(.title)
                .bold()

            Text(question.question)
                .font(.headline)

            ForEach(question.options.indices, id: \.self) { index in
                Button(action: {
                    if !isAnswered {
                        selectedIndex = index
                        isAnswered = true
                    }
                }) {
                    HStack {
                        Text(question.options[index])
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .background(self.backgroundColor(for: index))
                    .cornerRadius(8)
                    .foregroundColor(.primary)
                }
                .disabled(isAnswered)
            }

            if isAnswered {
                Text(selectedIndex == question.correctIndex ? "Correct!" : "Incorrect.")
                    .font(.headline)
                    .foregroundColor(selectedIndex == question.correctIndex ? .green : .red)
                    .padding(.top)
            }
        }
        .padding()
    }

    private func backgroundColor(for index: Int) -> Color {
        guard isAnswered else { return Color.gray.opacity(0.1) }

        if index == question.correctIndex {
            return Color.green.opacity(0.3)
        } else if index == selectedIndex {
            return Color.red.opacity(0.3)
        } else {
            return Color.gray.opacity(0.1)
        }
    }
}
