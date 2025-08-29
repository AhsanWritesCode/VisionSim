import SwiftUI

/// A simple view to display credits and acknowledgements
/// for the project, including authorship, supervision,
/// funding, and information sources.
struct CreditsView: View {
    var body: some View {
        VStack(spacing: 30) {
            // Title at the top
            Text("Credits")
                .font(.largeTitle)
                .bold()

            // Individual credit sections (author, supervisor, etc.)
            VStack(spacing: 16) {
                CreditSection(title: "Created by", content: "Ahsan Tariq")
                CreditSection(title: "Supervised by", content: "Dr. Christian Jacob")
                CreditSection(title: "Funding", content: "This research project was supported by Alberta Innovates.")
                CreditSection(title: "Impairment Information", content: "Information about impairments used in the About and Walkthrough views is sourced from the National Eye Institute.")
            }
            .padding(.horizontal)
            .multilineTextAlignment(.center)

            Spacer()
        }
        .padding(.top, 80) // push content down a bit for balance
    }

    /// Small helper to keep each credit block consistent in style.
    private func CreditSection(title: String, content: String) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}
