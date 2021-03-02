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
        VStack(spacing: 0) {
          // MARK: Reel #1
          ZStack {
            ReelView()
            Image("gfx-bell")
              .resizable()
              .modifier(ImageModifier())
          }
          HStack(spacing: 0) {
            // MARK: Reel #2
            ZStack {
              ReelView()
              Image("gfx-seven")
                .resizable()
                .modifier(ImageModifier())
            }
            Spacer()
            
            // MARK: Reel #3
            ZStack {
              ReelView()
              Image("gfx-cherry")
                .resizable()
                .modifier(ImageModifier())
            }
            
          } // :HStack
          .frame(maxWidth: 500)
          
          // MARK: Spin Button
          Button(action: {}) {
            Image("gfx-spin")
              .renderingMode(.original)
              .resizable()
              .modifier(ImageModifier())
          }
        } // :Slots
        .layoutPriority(2)
        // MARK: Footer
        Spacer()
        
        HStack {
          // MARK: Bet 20
          HStack(spacing: 10) {
            Button(action: {}) {
              Text("20")
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .modifier(BetNumberModifier())
            }
            .modifier(BetCapsuleModifier())
            Image("gfx-casino-chips")
              .resizable()
              .opacity(0)
              .modifier(CasinoChipsModifier())
          }
          
          // MARK: Bet 10
          HStack(spacing: 10) {
            Image("gfx-casino-chips")
              .resizable()
              .opacity(1)
              .modifier(CasinoChipsModifier())
            Button(action: {}) {
              Text("10")
                .fontWeight(.heavy)
                .foregroundColor(.yellow)
                .modifier(BetNumberModifier())
            }
            .modifier(BetCapsuleModifier())
          }
        }
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
