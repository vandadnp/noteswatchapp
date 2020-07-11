//
//  ContentView.swift
//  noteswatchapp WatchKit Extension
//
//  Created by Vandad Nahavandipoor on 2020-07-11.
//  Copyright © 2020 Pixolity AB. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("🎸").font(.caption)
            Button(
                "Beginner",
                action: {
                    
                }
            )
            Button(
                "Intermediate",
                action: {
                    
                }
            )
            Button(
                "Expert",
                action: {
                    
                }
            )
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
