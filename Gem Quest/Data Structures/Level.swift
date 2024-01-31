import SwiftUI

struct AllLevels: Codable {
    let numLevels: Int
    var allLevels: [Level]
    
    static func loadLevelsData() -> [Level] {
        print("Loading level data...")
        
        
        let decoder = JSONDecoder()
        
        guard let path = Bundle.main.path(forResource: "levels", ofType: "json") else { print("Couldn't find levels.json"); return []}
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { print("Couldn't load levels.json"); return []}
        
        do {
            let levelsContainer = try decoder.decode(AllLevels.self, from: data)
            return levelsContainer.allLevels
        } catch {
            print("didn't work: \(error)")
            return []
        }
    }
    
}


class Level: Identifiable, Codable {
    
    let name: String
    let unlockCost: Int
    let rawRes: [RawResource]
    var yieldRates: [String : Double]
    let bgImageName: String
    
    enum CodingKeys: String, CodingKey { case name, unlockCost, rawRes, yieldRates, bgImageName }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.unlockCost = try container.decode(Int.self, forKey: .unlockCost)
        self.rawRes = try container.decode([RawResource].self, forKey: .rawRes)
        self.bgImageName = try container.decode(String.self, forKey: .bgImageName)
        
        var yieldRatesDict: [String : Double] = [:]
        let yieldRatesArray = try container.decode([[String : Double]].self, forKey: .yieldRates)
        for yieldRate in yieldRatesArray {
            if let key = yieldRate.keys.first, let value = yieldRate.values.first {
                yieldRatesDict[key] = value
            }
        }
        
        self.yieldRates = yieldRatesDict
    }
    
    
    init(name: String, unlockCost: Int, rawRes: [RawResource], yieldRates: [String : Double], imageResource: String) {
        self.name = name
        self.unlockCost = unlockCost
        self.rawRes = rawRes
        self.yieldRates = yieldRates
        self.bgImageName = imageResource
        
    }
    
    var description: String {
        let mirror = Mirror(reflecting: self)
        var description = "\(type(of: self)) properties:\n"
        for child in mirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}
