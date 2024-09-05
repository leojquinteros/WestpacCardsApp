//
//  LoadingView.swift
//  WestpacCardsApp
//
//  Created by Leo Quinteros on 05/09/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView("Loading cards...")
                .progressViewStyle(.circular)
                .tint(.primary)
            Spacer()
        }
    }
}

#if DEBUG

#Preview {
    LoadingView()
}

#endif
