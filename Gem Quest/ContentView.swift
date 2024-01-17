//
//  ContentView.swift
//  Gem Quest
//
//  Created by Charlie Reeder on 1/16/24.
//

import SwiftUI
import Combine

class GameData: ObservableObject {
    @Published var coins = 0
    @Published var minesUnlocked: Int = 1

    func addCoins() {
        coins += 5 * minesUnlocked
    }
}


struct ContentView: View {
    
    @State var money: Int = 0
    
    
    @StateObject private var gameData = GameData()
    @State private var timer: AnyCancellable?
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text(gameData.coins.description)
                Text(gameData.minesUnlocked.description)
                
                ZStack {
                    Color.red
                }
                .frame(height: 200)
                
                if gameData.minesUnlocked >= 2 {
                    ZStack {
                        Color.green
                    }
                    .frame(height: 200)
                } else {
                    Text("unlock")
                        .onTapGesture {
                            if gameData.coins > 100 {//
                                gameData.minesUnlocked += 1
                            }
                        }
                }
                
                if gameData.minesUnlocked >= 3 {
                    ZStack {
                        Color.blue
                    }
                    .frame(height: 200)
                } else {
                    Text("unlock")
                        .onTapGesture {
                            if gameData.coins > 200 {
                                gameData.minesUnlocked += 1
                            }
                        }
                }
            }
        }
        .onAppear {
            self.startTimer()
        }
    }
    
    func startTimer() {
        timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect().sink { _ in
            gameData.addCoins()
        }
    }
}

#Preview {
    ContentView()
}
