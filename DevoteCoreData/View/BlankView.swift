//
//  BlankView.swift
//  DevoteCoreData
//
//  Created by Anthony on 11/11/24.
//

import SwiftUI

struct BlankView: View {
    //MARK: - PROPERTIES

  var backgroundColor: Color
  var backgroundOpacity: Double

    //MARK: - BODY
    var body: some View {
      VStack {
        Spacer()
          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
          .background(
            backgroundColor
          )
          .opacity(backgroundOpacity)
          .blendMode(.overlay)
          .ignoresSafeArea()
      } //: VSTACK
    }
}

#Preview {
  BlankView(backgroundColor: .black, backgroundOpacity: 0.3)
    .background(BackgroundImageView())
    .background(backgroundGradient.ignoresSafeArea())
}
