//
//  Gem_QuestApp.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/16/24.
//

import SwiftUI
import SwiftData

@main
struct Gem_QuestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: GameData.self)
                //.environmentObject(GameData())
            
        }
    }
}
