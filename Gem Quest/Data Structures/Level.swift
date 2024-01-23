//
//  Level.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/19/24.
//

import SwiftUI

class Level: Identifiable, Codable {
    
    let name: String
    let unlockCost: Int
    let coinsPerSecond: Int
    let rawRes: [RawResource]
    var yieldRates: [RawResource : Double]
    let imageResource: String
    
    init(name: String, unlockCost: Int, coinsPerSecond: Int, rawRes: [RawResource], yieldRates: [RawResource : Double], imageResource: String) {
        self.name = name
        self.unlockCost = unlockCost
        self.coinsPerSecond = coinsPerSecond
        self.rawRes = rawRes
        self.yieldRates = yieldRates
        self.imageResource = imageResource
    }
    
    static func loadLevelData() {
        let decoder = JSONDecoder()
        if let path = Bundle.main.path(forResource: "level", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            }
            catch { print("error loading level.json") }
            
        } else { print("couldn't find level.json") }
        
        do {
            
            //let person = try decoder.decode(Person.self, from: jsonData)
        } catch {
            
        }
    }
}
