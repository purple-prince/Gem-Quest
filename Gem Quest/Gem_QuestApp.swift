//
//  Gem_QuestApp.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/16/24.
//

import SwiftUI

@main
struct Gem_QuestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GameData())
        }
    }
}
