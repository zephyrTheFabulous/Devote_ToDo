//
//  BackgroundImageView.swift
//  DevoteCoreData
//
//  Created by Anthony on 11/11/24.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
      Image(.rocket)
        .antialiased(true)
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundImageView()
}
