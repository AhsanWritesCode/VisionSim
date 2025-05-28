//
//  InfoPanelViewWrapper.swift
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-28.
//

import SwiftUI

struct InfoPanelViewWrapper: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        InfoPanelView(impairment: appState.selectedImpairment)
    }
}
