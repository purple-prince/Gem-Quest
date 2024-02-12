//
//  GameData.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/31/24.
//

import Foundation
import Combine

// Todo: self / capturing self in swift, swiftful thinking

class GameData: ObservableObject {
    
    @Published var resAmounts: [RawResource : Int] = [:]
    @Published var mineRateMultipliers: [String : Double] = [:]
    let allLevels: [Level] = AllLevels.loadLevelsData()
    
    @Published var coins = 180
    @Published var minesUnlocked: Int = 1
    @Published var timer: AnyCancellable?
    @Published var activeLevels: [Level] = []
    @Published var levelsUnlocked: Int = 0
    
    var allResourcesValue: Int {
        var total = 0
        for res in Array(resAmounts.keys) { total += res.sellValue * resAmounts[res]! }
        return total
    }
    
    // TODO: optimize for performance
    var netWorth: Int {
        var total = coins
        
        for res in Array(resAmounts.keys) { total += res.sellValue * resAmounts[res]! }
        
        return total
    }
        
    let updateRate: Double = 0.5
    
    func sellRes(resource: RawResource, amount: Double) {
        var resToSell: Double = Double(resAmounts[resource]!)
        resToSell *= amount
        
        resAmounts[resource]! -= Int(resToSell)
        coins += Int(resToSell) * resource.sellValue
    }
    
    func addRes() {
        for level in activeLevels {
            for res in level.rawRes {
                let amountToAdd = Int(level.yieldRates[res.name]!)
                if resAmounts[res] != nil {
                    resAmounts[res]! += amountToAdd
                } else {
                    resAmounts[res] = Int(Double(amountToAdd) * mineRateMultipliers[level.name]!)
                }
            }
        }
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: updateRate, on: .main, in: .common).autoconnect().sink { _ in
            self.addRes()
        }
    }
    
    func unlockLevel() {
        let nextLevel = allLevels[levelsUnlocked]
        
        if coins >= nextLevel.unlockCost { // if we can afford the next level
            coins -= nextLevel.unlockCost  // pay the unlock cost
            mineRateMultipliers[nextLevel.name] = 1.0
            activeLevels.append(nextLevel) // set the level to active
            levelsUnlocked += 1            // increment the number of levels unlocked
        }
    }
}
