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
