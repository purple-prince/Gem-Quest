//
//  Level.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/19/24.
//

import SwiftUI

//    var description: String {
//        let mirror = Mirror(reflecting: self)
//        var description = "\(type(of: self)) properties:\n"
//        for child in mirror.children {
//            if let propertyName = child.label {
//                description += "\(propertyName): \(child.value)\n"
//            }
//        }
//        return description
//    }

//print(level.description)

class Level: Identifiable, Codable {
    
    let name: String
    let unlockCost: Int
    let rawRes: [RawResource]
    var yieldRates: [RawResource : Double]
    let bgImageName: String
    
    init(name: String, unlockCost: Int, rawRes: [RawResource], yieldRates: [RawResource : Double], imageResource: String) {
        self.name = name
        self.unlockCost = unlockCost
        self.rawRes = rawRes
        self.yieldRates = yieldRates
        self.bgImageName = imageResource
        
    }
    
    static func loadLevelData() -> Level? {
        print("loading...")
        let decoder = JSONDecoder()
        
        guard let path = Bundle.main.path(forResource: "levels", ofType: "json") else {
            print("couldn't find level.json")
            return nil
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            print("couldn't load level.json")
            return nil
        }
        
        do {
            let level = try decoder.decode(Level.self, from: data)
            print("WORKED!!")
            
            return level
            
        } catch {
            print("didnt work...")
            return nil
        }
        
        
    }
}
