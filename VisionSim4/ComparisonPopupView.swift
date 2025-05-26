//
//  ComparisonPopupView.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-26.
//

import SwiftUI


struct ComparisonPopupView: View {
    let title: String
    let imageName: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack {
                Text(title)
                    .font(.title2)
                    .padding()


                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding()

                Spacer()
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}
