//
//  AppState.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-27.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var selectedImpairment: VisionImpairment = .macularDegeneration
}
