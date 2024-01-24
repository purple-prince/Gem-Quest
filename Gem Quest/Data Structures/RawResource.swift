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
    
    enum CodingKeys: String, CodingKey { case name, sellValue, levelYields }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.sellValue = try container.decode(Int.self, forKey: .sellValue)
        
        let levelYieldArray = try container.decode([[String : Double]].self, forKey: .levelYields)
        
        var levelYieldsDictionary: [Int: Double] = [:]

        for levelYield in levelYieldArray {
            if let keyString = levelYield.keys.first, let intKey = Int(keyString), let value = levelYield.values.first {
                levelYieldsDictionary[intKey] = value
            }
        }

        levelYields = levelYieldsDictionary

    }
    
    init(name: String, sellValue: Int, levelYields: [Int : Double]) {
        self.name = name
        self.sellValue = sellValue
        self.levelYields = levelYields
    }
    
    static func resourceFromName(name: String) -> RawResource {
        switch name {
            case "Wood": return .wood
            default: return .wood
        }
    }
    
    static func nameOfResource(resource: RawResource) -> String {
        switch resource {
            case .wood: return "Wood"
            default: return "Wood"
        }
    }
}
    
//struct RawResource: Hashable, Codable {
//    let name: String
//    let sellValue: Int
//    var levelYields: [Int: Double]
//
//    enum CodingKeys: String, CodingKey {
//        case name, sellValue, levelYields
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        sellValue = try container.decode(Int.self, forKey: .sellValue)
//        
//        // Custom decoding for levelYields
//        let levelYieldArray = try container.decode([[String: Double]].self, forKey: .levelYields)
//        levelYields = levelYieldArray.reduce(into: [Int: Double]()) { dict, element in
//            guard let key = element.keys.first, let intKey = Int(key), let value = element.values.first else { return }
//            dict[intKey] = value
//        }
//    }
//}
