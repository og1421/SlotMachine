//
//  ContentView.swift
//  SlotMachine
//
//  Created by Orlando Moraes Martins on 07/03/23.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Properties
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    
    @State private var reels: Array = [0, 1, 2]
    @State private var showingInfoView: Bool = false
    @State private var highScore: Int = 0
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    
    //MARK: - Functions
    
    // spin the reels
    func spinReels() {
//        reels[0] = Int.random(in: 0...symbols.count - 1)
//        reels[1] = Int.random(in: 0...symbols.count - 1)
//        reels[2] = Int.random(in: 0...symbols.count - 1)
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
    }
    
    //check the winning
    func checkWinning() {
        if reels[0] == reels[1] && reels[0] == reels[2] {
            //Player wins
            playerWins()
            
            //new HighScore
            if coins > highScore {
                newHighScore()
            }
            
        } else {
            //Player loses
            playerLoses()
        }
    }
    
    //Player wins
    func playerWins() {
        coins += betAmount * 10
    }
    
    //New high score
    func newHighScore() {
        highScore = coins
    }
    
    //Player loses
    func playerLoses() {
        coins -= betAmount
    }
    
    func activateBet20 () {
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
    }
    
    func activateBet10 (){
        betAmount = 10
        isActiveBet10 = true
        isActiveBet20 = false
    }
    
    //Game is over
    
    //MARK: - Body
    var body: some View {
        ZStack{
            //MARK: - Background
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            //MARK: - Interface
            VStack(alignment: .center, spacing: 5) {
                //MARK: - Header
                LogoView()
                Spacer()
                
                //MARK: - Score
                HStack {
                    HStack{
                        Text("Your\ncoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("\(coins)")
                            .scoredNumberStyle()
                            .modifier(ScoredNumberModifier())
                    }//:HSTACK
                    .modifier(ScoreContainerModifier())
                    
                    
                    Spacer()
                    
                    HStack{
                        Text("\(highScore)")
                            .scoredNumberStyle()
                            .modifier(ScoredNumberModifier())

                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                    }//:HSTACK
                    .modifier(ScoreContainerModifier())
                }//:HSTACK
                
                
                //MARK: - Slot Machine
                VStack(alignment: .center, spacing: 0 ) {
                    //MARK: - Reel 1
                    ZStack {
                        ReelView()
                        
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                    }//:ZSTACK
                    
                    HStack{
                        //MARK: - Reel 2
                        ZStack {
                            ReelView()
                            
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                        }//:ZSTACK
                        
                        Spacer()
                        
                        //MARK: - Reel 3
                        ZStack {
                            ReelView()
                            
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                        }//:ZSTACK
                    }
                    .frame(maxWidth: 500)
                    
                    //MARK: - SpinButton
                    Button {
                        self.spinReels()
                        
                        //checkwinning
                        self.checkWinning()
                    }label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                }//:HSTACK
                .layoutPriority(2)
                
                
                //MARK: - Footer
                
                Spacer()
                
                HStack {
                    //MARK: - Bet 20
                    HStack(alignment: .center, spacing: 10) {
                        
                        Button {
                            self.activateBet20()
                        } label: {
                            Text( "20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet20 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                            
                        }//: BUtton
                        .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }//:HStack
                    
                    //MARK: - Bet 10
                    HStack(alignment: .center, spacing: 10) {
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        
                        Button {
                            self.activateBet10()
                        } label: {
                            Text( "10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet10 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                            
                        }//: BUtton
                        .modifier(BetCapsuleModifier())
                    
                    }//:HStack
                }//:HStack
            }//:VSTACK
            
            //MARK: - Buttons
            .overlay(
                //Reset
                Button {
                    print("Reset the game")
                } label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                    .modifier(ButtonModifier()),
                    alignment: .topLeading
            )
            .overlay(
                //INFO
                Button {
                    self.showingInfoView = true
                } label: {
                    Image(systemName: "info.circle")
                }
                    .modifier(ButtonModifier()),
                    alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
            .sheet(isPresented: $showingInfoView) {
                InfoView()
            }
            
            //MARK: - popup
        }//:ZSTACK
    }
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
