//
//  ContentView.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/16/24.
//

import SwiftUI
import Combine

class GameData: ObservableObject {
    @Published var coins = 0
    @Published var minesUnlocked: Int = 1

    func addCoins() {
        coins += 5 * minesUnlocked
    }
}


struct ContentView: View {
    
    @State var money: Int = 0
    
    
    @StateObject private var gameData = GameData()
    @State private var timer: AnyCancellable?
    
    let levels = [
        Level(name: "Level 1", color: .red, unlockCost: 10, coinsPerSecond: 10),
        Level(name: "Level 2", color: .orange, unlockCost: 100, coinsPerSecond: 100),
        Level(name: "Level 3", color: .yellow, unlockCost: 1_000, coinsPerSecond: 1_000),
        Level(name: "Level 4", color: .green, unlockCost: 10_000, coinsPerSecond: 10_000),
        Level(name: "Level 5", color: .teal, unlockCost: 100_000, coinsPerSecond: 100_000),
        Level(name: "Level 6", color: .cyan, unlockCost: 1_000_000, coinsPerSecond: 1_000_000),
        Level(name: "Level 7", color: .blue, unlockCost: 10_000_000, coinsPerSecond: 10_000_000),
        Level(name: "Level 8", color: .indigo, unlockCost: 100_000_000, coinsPerSecond: 100_000_000),
        Level(name: "Level 9", color: .purple, unlockCost: 1_000_000_000, coinsPerSecond: 1_000_000_000),
        Level(name: "Level 10", color: .brown, unlockCost: 10_000_000_000, coinsPerSecond: 10_000_000_000)
    ]
    
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text("Coins: " + gameData.coins.description)
                

            }
        }
        .onAppear {
            self.startTimer()
        }
    }
    
    func startTimer() {
        timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect().sink { _ in
            gameData.addCoins()
        }
    }
}

struct Level: Identifiable {
    let id: UUID = UUID()
    let name: String
    let color: Color
    let unlockCost: Int
    let coinsPerSecond: Int
}

#Preview {
    ContentView()
}
