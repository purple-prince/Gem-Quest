//
//  ContentView.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/16/24.
//

import SwiftUI
import Combine

struct ContentView: View {
        
    @StateObject private var gameData = GameData()
    
    @State var showHqSheet: Bool = false
    @State var showMarketSheet: Bool = true//false
    
    var formattedNumber: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: gameData.coins)) ?? ""
    }
}

extension ContentView {
    var body: some View {
        
        ZStack {
            
            //topPanel
            
            main
            
        }
    }
}

extension ContentView {
    
    var main: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                
                VStack {
                    
                    marketView
                    
                    hqView

                    ForEach(gameData.activeLevels) { level in

                        ZStack(alignment: .center) {
                            Color.blue

                            Text(level.name)
                        }
                        .frame(height: 200)
                    }

                    if gameData.levelsUnlocked < gameData.allLevels.count {
                        Text("Unlock level \(gameData.levelsUnlocked + 1) for \(gameData.allLevels[gameData.levelsUnlocked].unlockCost) coins")
                            .underline()
                            .bold()
                            .onTapGesture { gameData.unlockLevel() }
                    }
                }
                .frame(width: geo.size.width)
                .frame(minHeight: geo.size.height)
            }
            .onAppear { gameData.startTimer() }
            .sheet(isPresented: $showHqSheet) { HQSheet(gameData: gameData) }
            .sheet(isPresented: $showMarketSheet) { marketSheet }
        }
    }
    
    var marketView: some View {
        ZStack {
            Text("Market")
                .font(.title)
                .onTapGesture { showMarketSheet = true }
        }
        .frame(maxHeight: 200)
    }
    
    var marketSheet: some View {
        VStack {
            VStack {
                ForEach(Array(gameData.resAmounts.keys), id: \.self) { resource in
                    HStack {
                        Text("\(resource.name): \(gameData.resAmounts[resource]!)")
    
                        Spacer()
    
                        Text("Sell:")
    
                        Button(action: {
                            gameData.sellRes(resource: resource, amount: 0.1)
                        }) {
                            Text("10%")
                                .font(.body)
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundStyle(Color(red: 0.1, green: 0.1, blue: 0.1))
    
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color(red: 0.3, green: 0.3, blue: 0.3))
                                    }
    
                                )
                        }
    
                        Button(action: {
                            gameData.sellRes(resource: resource, amount: 0.5)
                        }) {
                            Text("50%")
                                .font(.body)
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundStyle(Color(red: 0.1, green: 0.1, blue: 0.1))
    
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color(red: 0.3, green: 0.3, blue: 0.3))
                                    }
    
                                )
                        }
    
                        Button(action: {
                            gameData.sellRes(resource: resource, amount: 1.0)
                        }) {
                            Text("100%")
                                .font(.body)
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundStyle(Color(red: 0.1, green: 0.1, blue: 0.1))
    
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color(red: 0.3, green: 0.3, blue: 0.3))
                                    }
    
                                )
                        }
                    }
                    .font(.title3)
    
                }
            }
        }
        .presentationDetents([.fraction(0.75)])
    }
    var hqView: some View {
        ZStack {
            Image("hqImage")
                .resizable()
                .blur(radius: 6)
                .onTapGesture {

                }
            
            VStack {
                Text("HQ")
                    .font(.title)
                
                ForEach(Array(gameData.resAmounts.keys), id: \.self) { key in
                    Text("\(key.name): \(gameData.resAmounts[key]!)")
                }
            }
        }
        .frame(height: 200)
        .onTapGesture { showHqSheet = true }
    }
}

#Preview {
    ContentView()
}
