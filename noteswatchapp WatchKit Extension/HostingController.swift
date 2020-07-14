//
//  HostingController.swift
//  noteswatchapp WatchKit Extension
//
//  Created by Vandad Nahavandipoor on 2020-07-11.
//  Copyright © 2020 Pixolity AB. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<ContentView> {
    override init() {
        super.init()
        Note.setupAudioSession()
    }
    override var body: ContentView {
        return ContentView()
    }
}
