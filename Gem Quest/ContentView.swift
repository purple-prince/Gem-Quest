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
        Level(
            name: "Level 1",
            color: .red,
            unlockCost: 10,
            coinsPerSecond: 10, 
            rawRes: [RawResoruce(name: "Wood", sellValue: 1, levelYields: [1 : 1.0])],
            yieldRates: ["Wood" : 1.0]
        ),
        Level(name: "Level 2", color: .orange, unlockCost: 100, coinsPerSecond: 100, rawRes: [], yieldRates: [:])
    ]
    
    @Published var resAmounts: [String : Int] = [:]
    
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
    
    func addRes() {
        for level in activeLevels {
            for res in level.rawRes {
                let amountToAdd = Int(level.yieldRates[res.name]!)
                if resAmounts[res.name] != nil {
                    resAmounts[res.name]! += amountToAdd
                } else {
                    resAmounts[res.name] = amountToAdd
                }
                
            }
        }
    }
    
    func sellRawResource(resource: RawResoruce, amount: Int) {
        self.coins -= resource.sellValue * amount
        
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: updateRate, on: .main, in: .common).autoconnect().sink { _ in
            self.addCoins(activeLevels: self.activeLevels)
            self.addRes()
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
        
        ZStack {
            
            topPanel
            
            main
            
        }
    }
    
    var main: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                
                VStack {
                    hqView

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
                .frame(width: geo.size.width)
                .frame(minHeight: geo.size.height)
                

            }
            .onAppear { gameData.startTimer() }
        }
        
    }
    
    var hqView: some View {
        ZStack {
            Image("hqImage")
                .resizable()
                .blur(radius: 6)
            
            VStack {
                Text("HQ")
                    .font(.title)
                
                ForEach(Array(gameData.resAmounts.keys), id: \.self) { key in
                    Text("\(key): \(gameData.resAmounts[key]!)")
                }
            }
        }
        .frame(height: 200)
        .border(Color.red)
        .onTapGesture {
            
        }
    }
    
    var topPanel: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                Text("Coins: " + formattedNumber)
            }
        }
    }
}

struct RawResoruce: Hashable {
    let name: String
    let sellValue: Int
    let levelYields: [Int : Double]
}

#Preview {
    ContentView()
}
