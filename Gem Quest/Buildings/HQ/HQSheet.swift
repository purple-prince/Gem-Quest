//
//  HQSheet.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/31/24.
//

import SwiftUI

struct HQSheet: View {
    
    @ObservedObject var gameData: GameData
    
    enum HQSheetTab { case overview, resources }
    @State var currentTab: HQSheetTab = .overview
    
    var body: some View {
        VStack {
            
            tabPicker
            
            Group {
                if currentTab == .overview {
                    VStack {
                        Text("Resource value: $\(gameData.netWorth)")
                    }
                } else if currentTab == .resources {
                    VStack {
                        ForEach(Array(gameData.resAmounts.keys), id: \.self) { resource in
                            HStack {
                                Text("\(resource.name): \(gameData.resAmounts[resource]!)")
                            }
                            .font(.title3)
                        }
                    }
                }
            }
            .padding(.top)

            Spacer()
            
        }
        .padding()
        .presentationDetents([.fraction(0.75)])
    }
    
    var tabPicker: some View {
        Picker("", selection: $currentTab) {
            Text("Overview")
                .tag(HQSheetTab.overview)
             
            Text("Resources")
                .tag(HQSheetTab.resources)
                
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
