//
//  InfoView.swift
//  SlotMachine
//
//  Created by Víctor Manuel Puga Ruiz on 21/03/21.
//

import SwiftUI

struct InfoView: View {
  // MARK: - Properties
  @Environment(\.presentationMode) var presentationMode
  
  
  // MARK: - Body
  var body: some View {
    VStack(spacing: 10) {
      LogoView()
      Spacer()
      
      Form {
        Section(header: Text("About")) {
          FormRowView(firstItem: "Application", secondItem: "Slot Machine")
          FormRowView(firstItem: "Platforms", secondItem: "iPhone, iPad, Mac")
          FormRowView(firstItem: "Developer", secondItem: "VictorPuga")
          FormRowView(firstItem: "Designer", secondItem: "Robert Petras")
          FormRowView(firstItem: "Music", secondItem: "Dan Lebowitz")
          FormRowView(firstItem: "Website", secondItem: "swiftuimasterclass.com")
          FormRowView(firstItem: "Copyright", secondItem: "© 2021 All rights reserved.")
          FormRowView(firstItem: "Version", secondItem: "1.0.0")
        }
      }
      .font(.system(.body, design: .rounded))
    }
    .padding(.top, 40)
    .overlay(
      Button(action: {
        presentationMode.wrappedValue.dismiss()
      }) {
        Image(systemName: "xmark.circle")
          .font(.title)
      }
      .padding(.top, 30)
      .padding(.trailing, 20)
      .accentColor(.secondary)
      , alignment: .topTrailing
    )
    .onAppear {
      playSound(sound: "background-music", type: "mp3")
    }
    .onDisappear {
      audioPlayer?.stop()
    }
  }
}

// MARK: - Row
struct FormRowView: View {
  // MARK: - Properties
  let firstItem: String
  
  let secondItem: String
  
  // MARK: - Body
  var body: some View {
    HStack {
      Text(firstItem)
        .foregroundColor(.gray)
      Spacer()
      Text(secondItem)
    }
  }
}

// MARK: - Preview
struct InfoView_Previews: PreviewProvider {
  static var previews: some View {
    InfoView()
  }
}

