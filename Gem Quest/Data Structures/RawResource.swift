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
    
    init(name: String, sellValue: Int, levelYields: [Int : Double]) {
        self.name = name
        self.sellValue = sellValue
        self.levelYields = levelYields
    }
}
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.sellValue = try container.decode(Int.self, forKey: .sellValue)
//        self.levelYields = try container.decode([Int : Double].self, forKey: .levelYields)
//    }
//}
