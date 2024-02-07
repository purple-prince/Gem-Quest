//
//  LevelSheet.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 2/6/24.
//

import SwiftUI

struct LevelSheet: View {
    
    @EnvironmentObject var gameData: GameData
    
    @State var tab: MenuTab = .upgrades//.resources
    let level: Level
    
    
    enum MenuTab { case resources, upgrades }
    
    var body: some View {
        VStack {
            Picker("", selection: $tab) {
                Text("Resources")
                    .tag(MenuTab.resources)
                
                Text("Upgrades")
                    .tag(MenuTab.upgrades)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Spacer()
                        
            if tab == .resources {
                List {
                    ForEach(level.rawRes, id: \.name) { res in
                        HStack {
                            Text(res.name)
                            
                            Spacer()//
                            
                            Text(gameData.resAmounts[res]?.description ?? "0")
                        }
                    }
                }
            } else if tab == .upgrades {
                Text(level.name)
                Text(gameData.mineRateMultipliers.description)
                List {
                    HStack {
                        Text("Mine Rate: \(gameData.mineRateMultipliers[level.name]?.description ?? "S")")
                        
                        Spacer()
                        
                        ZStack {
                            Text("$2.83k")
                                .font(.callout)
                                .foregroundStyle(Color.yellow)
                            .padding(6)
                            .padding(.horizontal, 4)
                                .background(
                                    ZStack {
                                        Capsule()
                                            .stroke(Color.yellow, lineWidth: 2)
                                    }
                                )
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    LevelSheet(level: Level(name: "Level 1", unlockCost: 10, rawRes: [RawResource.wood], yieldRates: ["Wood" : 1.0], imageResource: ""))
        .environmentObject(GameData())
}
