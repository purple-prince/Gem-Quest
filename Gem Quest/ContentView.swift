//
//  ContentView.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/16/24.
//

import SwiftUI
import Combine

class GameData: ObservableObject {
    @Published var coins = 10
    @Published var minesUnlocked: Int = 1

    func addCoins(activeLevels: [Level]) {
        for level in activeLevels {
            coins += Int(Double(level.coinsPerSecond) * Double.random(in: 0.5..<1.5))
        }
    }
}


struct ContentView: View {
        
    @StateObject private var gameData = GameData()
    @State private var timer: AnyCancellable?
    
    let allLevels = [
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
    
    @State var activeLevels: [Level] = []
    @State var levelsUnlocked: Int = 0
    
    var formattedNumber: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: gameData.coins)) ?? ""
    }
    
    
    var body: some View {
        VStack {
            Text("Coins: " + formattedNumber)
            
            ScrollView {
                VStack {
                    
                    
                    
                    ForEach(activeLevels) { level in
                        
                        ZStack(alignment: .center) {
                            level.color
                            
                            Text(level.name)
                        }
                        .frame(height: 200)
                    }
                    
                    if levelsUnlocked < allLevels.count {
                        Text("Unlock level \(levelsUnlocked + 1) for \(allLevels[levelsUnlocked].unlockCost) coins").underline().bold()
                            .onTapGesture {
                                if gameData.coins >= allLevels[levelsUnlocked].unlockCost {
                                    gameData.coins -= allLevels[levelsUnlocked].unlockCost
                                    activeLevels.append(allLevels[levelsUnlocked])
                                    levelsUnlocked += 1
                                }
                            }
                    }
                }
            }
            .onAppear {
                self.startTimer()
            }
        }

    }
    
    func startTimer() {
        timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect().sink { _ in
            gameData.addCoins(activeLevels: activeLevels)
        }
    }
}

class Level: Identifiable {
    
    @Published var isUnlocked: Bool = false
    let id: UUID = UUID()
    let name: String
    let color: Color
    let unlockCost: Int
    let coinsPerSecond: Int
    
    init(name: String, color: Color, unlockCost: Int, coinsPerSecond: Int) {
        self.name = name
        self.color = color
        self.unlockCost = unlockCost
        self.coinsPerSecond = coinsPerSecond
    }
}

#Preview {
    ContentView()
}
