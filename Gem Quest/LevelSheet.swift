//
//  LevelSheet.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 2/6/24.
//

import SwiftUI

struct LevelSheet: View {
    
    @State var showSheet = true
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .sheet(isPresented: $showSheet) {
//                NewView()
//            }
    }
}

struct NewView: View {
    
    @EnvironmentObject var gameData: GameData
    
    @State var tab: MenuTab = .resources
    //let level: Level = Level(name: "Wood", unlockCost: 10, rawRes: [RawResource.wood], yieldRates: ["Wood" : 1.0], imageResource: "")
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
                            
                            Spacer()
                            
                            Text(gameData.resAmounts[res]?.description ?? "0")
                        }
                    }
                }
            } else if tab == .upgrades {
                
            }
        }
        .padding()
    }
}

#Preview {
    LevelSheet()
        .environmentObject(GameData())
}
