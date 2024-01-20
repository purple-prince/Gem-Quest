//
//  Level.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/19/24.
//

import Foundation
import SwiftUI

class Level: Identifiable {
    
    @Published var isUnlocked: Bool = false
    let id: UUID = UUID()
    let name: String
    let color: Color
    let unlockCost: Int
    let coinsPerSecond: Int
    let rawRes: [RawResource]
    var yieldRates: [RawResource : Double]
    
    init(name: String, color: Color, unlockCost: Int, coinsPerSecond: Int, rawRes: [RawResource], yieldRates: [RawResource : Double]) {
        self.name = name
        self.color = color
        self.unlockCost = unlockCost
        self.coinsPerSecond = coinsPerSecond
        self.rawRes = rawRes
        self.yieldRates = yieldRates
    }
}
