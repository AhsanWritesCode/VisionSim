//
//  InfoPanelView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-27.
//

import SwiftUI

struct InfoPanelView: View {
    let impairment: VisionImpairment
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                VStack(spacing: 25) {
                    Text("About \(impairment.rawValue)")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)

                    Text("""
                        Detailed information about \(impairment.rawValue) goes here. You can describe the symptoms, causes, and how the simulation approximates the effect.
                        """)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 450)
                }

                Spacer()
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
