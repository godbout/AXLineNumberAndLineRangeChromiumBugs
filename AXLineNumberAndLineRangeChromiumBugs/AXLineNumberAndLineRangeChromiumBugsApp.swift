//
//  AXLineNumberAndLineRangeChromiumBugsApp.swift
//  AXLineNumberAndLineRangeChromiumBugs
//
//  Created by Guillaume Leclerc on 07/06/2025.
//

import SwiftUI

@main
struct AXLineNumberAndLineRangeChromiumBugsApp: App {
    init() {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        _ = AXIsProcessTrustedWithOptions(options)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .defaultSize(width: 288, height: 188)
        .defaultPosition(.topLeading)
    }
}
