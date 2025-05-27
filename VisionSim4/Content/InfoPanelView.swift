//
//  InfoPanelView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-27.
//

import SwiftUI

// Information panel view
struct InfoPanelView: View {
    let impairment: VisionImpairment
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text(impairment.rawValue)
                        .font(.title)
                        .bold()

                    Text("Detailed information about \(impairment.rawValue) goes here. You can describe symptoms, causes, and how the simulation approximates the effect.")
                        .font(.body)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("About")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
