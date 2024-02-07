//
//  LevelView.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 2/7/24.
//

import SwiftUI

struct LevelView: View {
    let level: Level
    
    @State var showSheet: Bool = false
}

extension LevelView {
    
    var body: some View {
        ZStack {
            Color(red: Double.random(in: 0..<1), green: Double.random(in: 0..<1), blue: Double.random(in: 0..<1))
        }
        .frame(height: 200)
        .onTapGesture {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            LevelSheet(level: level)
        }
    }
}

extension LevelView {
    
}

extension LevelView {
    
}

#Preview {
    LevelView(level: Level(name: "Level 1", unlockCost: 10, rawRes: [RawResource.wood], yieldRates: ["Wood" : 1.0], imageResource: ""))
}
