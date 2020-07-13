//
//  ContentView.swift
//  noteswatchapp WatchKit Extension
//
//  Created by Vandad Nahavandipoor on 2020-07-11.
//  Copyright © 2020 Pixolity AB. All rights reserved.
//

import SwiftUI

var difficulty = Difficulty.beginner

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: GameView(difficulty: .beginner)) {
                Text("🥴 Beginner")
            }
            NavigationLink(destination: GameView(difficulty: .intermediate)) {
                Text("😬 Intermediate")
            }
            
            NavigationLink(destination: GameView(difficulty: .expert)) {
                Text("🤟🏻 Expert")
            }
        }
        .navigationBarTitle("🎸 chords")
    }
}
