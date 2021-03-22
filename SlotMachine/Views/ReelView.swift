//
//  ReelView.swift
//  SlotMachine
//
//  Created by Víctor Manuel Puga Ruiz on 01/03/21.
//

import SwiftUI

struct ReelView: View {
  // MARK: - Body
  var body: some View {
    Image("gfx-reel")
      .resizable()
      .scaledToFit()
      .modifier(ImageModifier())
  }
}

// MARK: - Preview
struct ReelView_Previews: PreviewProvider {
  static var previews: some View {
    ReelView()
      .previewLayout(.fixed(width: 220, height: 220))
      .padding()
  }
}
