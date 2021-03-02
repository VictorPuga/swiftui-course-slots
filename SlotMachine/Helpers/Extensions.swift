//
//  Extensions.swift
//  SlotMachine
//
//  Created by Víctor Manuel Puga Ruiz on 01/03/21.
//

import SwiftUI

extension Text {
  func scoreLabelStyle() -> Text {
    self
      .foregroundColor(.white)
      .font(.system(size: 10, weight: .bold, design: .rounded))
  }
  
  func scoreNumberStyle() -> Text {
    self
      .foregroundColor(.white)
      .font(.system(.title, design: .rounded))
      .fontWeight(.heavy)
  }
}

extension Color {
  static var colorPink: Color { Color("ColorPink") }
  
  static var colorPurlple: Color { Color("ColorPurple") }
  
  static var colorYellow: Color { Color("ColorYellow") }
  
  static var colorTransparentBlack: Color { Color("ColorTransparentBlack") }
}
