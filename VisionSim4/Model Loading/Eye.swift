//
//  ContentView.swift
//  window3dtest
//
//  Created by Ahsan Tariq on 2025-08-04.
//

import SwiftUI
import RealityKit
import RealityKitContent


struct Eye: View {
    @State private var isRotating = 0.0
    
    var body: some View {
        Model3D(named: "EyeModel") {
            EyeModel in
            EyeModel
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(0.3)
                .rotation3DEffect(
                    .degrees(isRotating * 2), axis: (x: 15, y: -15, z: 15)
                )
        } placeholder: {
            ProgressView()
        }
        .toolbar {
            ToolbarItem(placement: .bottomOrnament) {
                VStack {
                    Slider(value: $isRotating, in: 0...359)
                        .frame(width: 360)
                        .padding()
                }
            }
        }
    }
}
//
//#Preview(windowStyle: .plain) {
//    Eye()
//}
