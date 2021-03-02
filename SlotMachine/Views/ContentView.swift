//
//  ContentView.swift
//  SlotMachine
//
//  Created by Víctor Manuel Puga Ruiz on 01/03/21.
//

import SwiftUI

struct ContentView: View {
  // MARK: - Properties
  
  
  
  // MARK: - Body
  var body: some View {
    ZStack {
      // MARK: Background
      LinearGradient(
        gradient: Gradient(
          colors: [.colorPink, .colorPurlple]
        ),
        startPoint: .top,
        endPoint: .bottom
      )
      .edgesIgnoringSafeArea(.all)
      
      VStack(alignment: .center, spacing: 5) {
        // MARK: Header
        LogoView()
        Spacer()
        
        // MARK: Score
        HStack {
          HStack {
            Text("Your\nCoins".uppercased())
              .scoreLabelStyle()
              .multilineTextAlignment(.trailing)
            Text("100")
              .scoreNumberStyle()
              .modifier(ScoreNumberModifier())
          }
          .modifier(ScoreContainerModifier())
          
          Spacer()
          
          HStack {
            Text("200")
              .scoreNumberStyle()
              .modifier(ScoreNumberModifier())
            Text("High\nScore".uppercased())
              .scoreLabelStyle()
              .multilineTextAlignment(.leading)
          }
          .modifier(ScoreContainerModifier())
        }
        // MARK: Slot Machine
        // MARK: Footer
        Spacer()
      }
      // MARK: Buttons
      .overlay(
        Button(action: {}) {
          Image(systemName: "arrow.2.circlepath.circle")
        }
        .modifier(ButtonModifier()),
        alignment: .topLeading
      ) // :Reset button
      .overlay(
        Button(action: {}) {
          Image(systemName: "info.circle")
        }
        .modifier(ButtonModifier()),
        alignment: .topTrailing
      ) // :Info button
      .padding()
      .frame(maxWidth: 720)
    }
  }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
