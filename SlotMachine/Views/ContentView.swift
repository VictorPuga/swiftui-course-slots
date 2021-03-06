//
//  ContentView.swift
//  SlotMachine
//
//  Created by Víctor Manuel Puga Ruiz on 01/03/21.
//

import SwiftUI

struct ContentView: View {
  // MARK: - Properties
  let symbols: [String] = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
  
  let haptics = UINotificationFeedbackGenerator()
  
  @State private var showingInfoView: Bool = false
  
  @State private var reels: [Int] = [0, 1, 2]
  
  @State private var highscore: Int = UserDefaults.standard.integer(forKey: "HighScore")
  
  @State private var coins: Int = 100
  
  @State private var betAmount: Int = 10
  
  @State private var showingModal: Bool = false
  
  @State private var animatingSymbol = false
  
  @State private var animatingModal: Bool = false
  
  var isActiveBet10: Bool { betAmount == 10 }
  
  var isActiveBet20: Bool { betAmount == 20 }
  
  
  // MARK: - Functions
  
  func spinReels() {
    reels = reels.map { _ in Int.random(in: 0..<symbols.count) }
    playSound(sound: "spin", type: "mp3")
    haptics.notificationOccurred(.success)
  }
  
  func checkWinning() {
    let first = reels[0]
    if reels.allSatisfy({ $0 == first }) {
      playerWins()
      
      if coins > highscore {
        newHighscore()
      } else {
        playSound(sound: "win", type: "mp3")
      }
    } else {
      playerLoses()
    }
  }
  
  func playerWins() {
    coins += betAmount * 10
  }
  
  func newHighscore() {
    highscore = coins
    UserDefaults.standard.set(highscore, forKey: "HighScore")
    playSound(sound: "high-score", type: "mp3")
  }
  
  func playerLoses() {
    coins -= betAmount
  }
  
  func activateBet(_ amount: Int) {
    betAmount = amount
    playSound(sound: "casino-chips", type: "mp3")
    haptics.notificationOccurred(.success)
  }
  
  func isGameOver() {
    if coins <= 0 {
      showingModal = true
      playSound(sound: "game-over", type: "mp3")
    }
  }
  
  func resetGame() {
    UserDefaults.standard.set(0, forKey: "HighScore")
    highscore = 0
    coins = 100
    activateBet(10)
    playSound(sound: "chimeup", type: "mp3")
  }
  
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
            Text("\(coins)")
              .scoreNumberStyle()
              .modifier(ScoreNumberModifier())
          }
          .modifier(ScoreContainerModifier())
          
          Spacer()
          
          HStack {
            Text("\(highscore)")
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
            Image(symbols[reels[0]])
              .resizable()
              .modifier(ImageModifier())
              .opacity(animatingSymbol ? 1 : 0)
              .offset(y: animatingSymbol ? 0 : -50)
              .animation(.easeOut(duration: Double.random(in: 0.5...0.7)))
              .onAppear {
                animatingSymbol.toggle()
                playSound(sound: "riseup", type: "mp3")
              }
          }
          HStack(spacing: 0) {
            // MARK: Reel #2
            ZStack {
              ReelView()
              Image(symbols[reels[1]])
                .resizable()
                .modifier(ImageModifier())
                .opacity(animatingSymbol ? 1 : 0)
                .offset(y: animatingSymbol ? 0 : -50)
                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))
                // .onAppear { animatingSymbol.toggle() }
            }
            Spacer()
            
            // MARK: Reel #3
            ZStack {
              ReelView()
              Image(symbols[reels[2]])
                .resizable()
                .modifier(ImageModifier())
                .opacity(animatingSymbol ? 1 : 0)
                .offset(y: animatingSymbol ? 0 : -50)
                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)))
                .animation(.easeOut)
                // .onAppear { animatingSymbol.toggle() }
            }
            
          } // :HStack
          .frame(maxWidth: 500)
          
          // MARK: Spin Button
          Button(action: {
            withAnimation {
              animatingSymbol = false
            }
            
            spinReels()
            
            withAnimation {
              animatingSymbol = true
            }
            
            checkWinning()
            isGameOver()
          }) {
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
            Button(action: {
              activateBet(20)
            }) {
              Text("20")
                .fontWeight(.heavy)
                .foregroundColor(isActiveBet20 ? .colorYellow : .white)
                .modifier(BetNumberModifier())
            }
            .modifier(BetCapsuleModifier())
            Image("gfx-casino-chips")
              .resizable()
              .offset(x: isActiveBet20 ? 0 : 20)
              .opacity(isActiveBet20 ? 1: 0)
              .modifier(CasinoChipsModifier())
          }
          
          Spacer()
          
          // MARK: Bet 10
          HStack(spacing: 10) {
            Image("gfx-casino-chips")
              .resizable()
              .offset(x: isActiveBet10 ? 0 : -20)
              .opacity(isActiveBet10 ? 1: 0)
              .modifier(CasinoChipsModifier())
            Button(action: {
              activateBet(10)
            }) {
              Text("10")
                .fontWeight(.heavy)
                .foregroundColor(isActiveBet10 ? .colorYellow : .white)
                .modifier(BetNumberModifier())
            }
            .modifier(BetCapsuleModifier())
          }
        }
      }
      // MARK: Buttons
      .overlay(
        Button(action: {
          resetGame()
        }) {
          Image(systemName: "arrow.2.circlepath.circle")
        }
        .modifier(ButtonModifier()),
        alignment: .topLeading
      ) // :Reset button
      .overlay(
        Button(action: {
          showingInfoView = true
        }) {
          Image(systemName: "info.circle")
        }
        .modifier(ButtonModifier()),
        alignment: .topTrailing
      ) // :Info button
      .padding()
      .frame(maxWidth: 720)
      .blur(radius: showingModal ? 5: 0, opaque: false)
      
      // MARK: Popup
      if showingModal {
        ZStack {
          Color.colorTransparentBlack
            .edgesIgnoringSafeArea(.all)
          VStack(spacing: 0) {
            Text("GAME OVER")
              .font(.system(.title, design: .rounded))
              .fontWeight(.heavy)
              .padding()
              .frame(minWidth: 0, maxWidth: .infinity)
              .background(Color.colorPink)
              .foregroundColor(.white)
            Spacer()
            VStack(spacing: 10) {
              Image("gfx-seven-reel")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 72)
              Text("Bak luck! You lost all of the coins. \nLet's play again!")
                .font(.system(.body, design: .rounded))
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .layoutPriority(1)
              Button(action: {
                showingModal = false
                animatingModal = false
                activateBet(10)
                coins = 100
              }) {
                Text("New Game".uppercased())
                  .font(.system(.body, design: .rounded))
                  .fontWeight(.semibold)
                  .accentColor(.colorPink)
                  .padding(.horizontal, 12)
                  .padding(.vertical, 8)
                  .frame(minWidth: 128)
                  .background(
                    Capsule()
                      .strokeBorder(lineWidth: 1.75)
                      .foregroundColor(.colorPink)
                  )
              }
            }
            Spacer()
          }
          .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
          .background(Color.white)
          .cornerRadius(20)
          .shadow(color: .colorTransparentBlack, radius: 6, x: 0, y: 8 )
          .opacity(animatingModal ? 1 : 0)
          .offset(y: animatingModal ? 0 : -100)
          .animation(.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0))
          .onAppear {
            animatingModal = true
          }
        }
      }
      
    } // :ZStack
    .sheet(isPresented: $showingInfoView) {
      InfoView()
    }
  }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
