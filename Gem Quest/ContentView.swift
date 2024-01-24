//
//  ContentView.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/16/24.
//

import SwiftUI
import Combine


// Todo: self / capturing self in swift, swiftful thinking

class GameData: ObservableObject {
    
    @Published var resAmounts: [RawResource : Int] = [:]
    let allLevels: [Level] = AllLevels.loadLevelsData()
    
    @Published var coins = 110
    @Published var minesUnlocked: Int = 1
    @Published var timer: AnyCancellable?
    @Published var activeLevels: [Level] = []
    @Published var levelsUnlocked: Int = 0
        
    let updateRate: Double = 0.5
    
    func sellRes(resource: RawResource, amount: Double) {
        var resToSell: Double = Double(resAmounts[resource]!)
        resToSell *= amount
        
        resAmounts[resource]! -= Int(resToSell)
        coins += Int(resToSell) * resource.sellValue
    }
    
    func addRes() {
        for level in activeLevels {
            print(level.name)
            for res in level.rawRes {
                print(res.name, "S")
                let amountToAdd = Int(level.yieldRates[res.name]!) // here
                if resAmounts[res] != nil { resAmounts[res]! += amountToAdd }
                else                          { resAmounts[res] = amountToAdd }
            }
        }
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: updateRate, on: .main, in: .common).autoconnect().sink { _ in
            self.addRes()
        }
    }
    
    func unlockLevel() {
        let nextLevel = allLevels[levelsUnlocked]
        
        if coins >= nextLevel.unlockCost { // if we can afford the next level
            coins -= nextLevel.unlockCost  // pay the unlock cost
            activeLevels.append(nextLevel) // set the level to active
            levelsUnlocked += 1            // increment the number of levels unlocked
        }
    }
}


struct ContentView: View {
        
    @StateObject private var gameData = GameData()
    
    @State var showHqSheet: Bool = false
    
    var formattedNumber: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: gameData.coins)) ?? ""
    }
    
    var body: some View {
        
        ZStack {
            
            //topPanel
            
            main
            
        }
    }
    
    var main: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                
                VStack {
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
        }
        
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
        .border(Color.red)
        
        .sheet(isPresented: $showHqSheet) {
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
            .padding()
            .presentationDetents([.fraction(0.75)])
        }
        
        
    }
}

#Preview {
    ContentView()
}
