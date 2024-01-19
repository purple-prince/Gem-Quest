//
//  ContentView.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/16/24.
//

import SwiftUI
import Combine

let tier1Ores: [String] = [
    "Wood", "Iron"
]

// Todo: self / capturing self in swift, swiftful thinking

class GameData: ObservableObject {
    
    let allLevels = [
        Level(name: "Level 1", color: .red, unlockCost: 10, coinsPerSecond: 10, rawRes: ["Wood"], rawYields: [], rawRates: []),
        Level(name: "Level 2", color: .orange, unlockCost: 100, coinsPerSecond: 100, rawRes: [], rawYields: [], rawRates: []),
        Level(name: "Level 3", color: .yellow, unlockCost: 1_000, coinsPerSecond: 1_000, rawRes: [], rawYields: [], rawRates: []),
        Level(name: "Level 4", color: .green, unlockCost: 10_000, coinsPerSecond: 10_000, rawRes: [], rawYields: [], rawRates: []),
        Level(name: "Level 5", color: .teal, unlockCost: 100_000, coinsPerSecond: 100_000, rawRes: [], rawYields: [], rawRates: []),
        Level(name: "Level 6", color: .cyan, unlockCost: 1_000_000, coinsPerSecond: 1_000_000, rawRes: [], rawYields: [], rawRates: []),
        Level(name: "Level 7", color: .blue, unlockCost: 10_000_000, coinsPerSecond: 10_000_000, rawRes: [], rawYields: [], rawRates: []),
        Level(name: "Level 8", color: .indigo, unlockCost: 100_000_000, coinsPerSecond: 100_000_000, rawRes: [], rawYields: [], rawRates: []),
        Level(name: "Level 9", color: .purple, unlockCost: 1_000_000_000, coinsPerSecond: 1_000_000_000, rawRes: [], rawYields: [], rawRates: []),
        Level(name: "Level 10", color: .brown, unlockCost: 10_000_000_000, coinsPerSecond: 10_000_000_000, rawRes: [], rawYields: [], rawRates: [])
    ]
    
    @Published var coins = 10
    @Published var minesUnlocked: Int = 1
    @Published var timer: AnyCancellable?
    @Published var activeLevels: [Level] = []
    @Published var levelsUnlocked: Int = 0
    
    let updateRate: Double = 0.5

    func addCoins(activeLevels: [Level]) {
        for level in activeLevels {
            coins += Int(Double(level.coinsPerSecond) * updateRate)
        }
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: updateRate, on: .main, in: .common).autoconnect().sink { _ in
            self.addCoins(activeLevels: self.activeLevels)
        }
    }
    
    func unlockLevel() {
        let nextLevel = allLevels[levelsUnlocked]
        
        if coins >= nextLevel.unlockCost { // if we can afford the next level
            coins -= nextLevel.unlockCost  // pay the unlock cost
            activeLevels.append(nextLevel) // set the level to active
            levelsUnlocked += 1            // increment the number of levels unlocked
        }
    }
}


struct ContentView: View {
        
    @StateObject private var gameData = GameData()
    
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
                    
                    ForEach(gameData.activeLevels) { level in
                        
                        ZStack(alignment: .center) {
                            level.color
                            
                            Text(level.name)
                        }
                        .frame(height: 200)
                    }
                    
                    if gameData.levelsUnlocked < gameData.allLevels.count {
                        Text("Unlock level \(gameData.levelsUnlocked + 1) for \(gameData.allLevels[gameData.levelsUnlocked].unlockCost) coins")
                            .underline()
                            .bold()
                            .onTapGesture { gameData.unlockLevel() }
                    }
                }
            }
            .onAppear { gameData.startTimer() }
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
    let rawRes: [String]
    let rawYields: [Double]
    var rawRates: [Double]
    
    init(name: String, color: Color, unlockCost: Int, coinsPerSecond: Int, rawRes: [String], rawYields: [Double], rawRates: [Double]) {
        self.name = name
        self.color = color
        self.unlockCost = unlockCost
        self.coinsPerSecond = coinsPerSecond
        self.rawRes = rawRes
        self.rawYields = rawYields
        self.rawRates = rawRates
    }
}

#Preview {
    ContentView()
}
