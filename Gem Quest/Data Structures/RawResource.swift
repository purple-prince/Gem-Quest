//
//  RawResource.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/19/24.
//

import Foundation

struct RawResource: Hashable, Codable {
    let name: String
    let sellValue: Int
    let levelYields: [Int : Double]
    
    static let wood: RawResource = RawResource(name: "Wood", sellValue: 1, levelYields: [1 : 1.0])
}
