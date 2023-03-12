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
    @State private var highScore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    @State private var showingModal: Bool = false
    @State private var animatingSymbol: Bool = false
    @State private var animatingModel: Bool = false
    
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
        UserDefaults.standard.set(highScore, forKey: "HighScore")
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
    func isGameOver() {
        if coins <= 0 {
            //show modal window
            showingModal = true
            
        }
    }
    
    //reset game
    func resetGame() {
        UserDefaults.standard.set(0, forKey: "HighScore")
        highScore = 0
        coins = 100
        activateBet10()
    }
    
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
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -50 )
                            .animation(.easeOut(duration: Double.random(in: 0.5...0.7)))
                            .onAppear(perform: {
                                self.animatingSymbol.toggle()
                            })
                    }//:ZSTACK
                    
                    HStack{
                        //MARK: - Reel 2
                        ZStack {
                            ReelView()
                            
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50 )
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                })
                        }//:ZSTACK
                        
                        Spacer()
                        
                        //MARK: - Reel 3
                        ZStack {
                            ReelView()
                            
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50 )
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)))
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                })
                        }//:ZSTACK
                    }
                    .frame(maxWidth: 500)
                    
                    //MARK: - SpinButton
                    Button {
                        //Set the default state: No animation
                        withAnimation{
                            self.animatingSymbol = false
                        }
                        
                        self.spinReels()
                        
                        // trigger the animation after changing the symbols
                        withAnimation {
                            self.animatingSymbol = true
                        }
                        
                        //checkwinning
                        self.checkWinning()
                        
                        //Game over
                        self.isGameOver()
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
                            .offset(x: isActiveBet20 ? 0 : 20)
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }//:HStack
                    
                    Spacer()
                    
                    //MARK: - Bet 10
                    HStack(alignment: .center, spacing: 10) {
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: isActiveBet10 ? 0 : -20)
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
                    self.resetGame()
                } label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                    .modifier(ButtonModifier()),
                    alignment: .topLeading
            ) // reset button
            .overlay(
                //INFO
                Button {
                    self.showingInfoView = true
                } label: {
                    Image(systemName: "info.circle")
                }
                    .modifier(ButtonModifier()),
                    alignment: .topTrailing
            ) //info button
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: $showingModal.wrappedValue ? 5 : 0 , opaque: false)
               
            //MARK: - popup
            
            if $showingModal.wrappedValue {
                ZStack {
                    Color("ColorTransparentBlack").edgesIgnoringSafeArea(.all)
                    
                    //Modal
                    VStack(spacing: 0){
                        Text("Game Over")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(
                                Color("ColorPink")
                            )
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        //Message
                        VStack(alignment: .center, spacing: 16){
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            
                            Text("Bad luck! you lost all of the coins. \nLet's play again")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                            
                            Button{
                                self.showingModal = false
                                self.animatingModel = false
                                self.activateBet10()
                                self.coins = 100
                            }label: {
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )
                            }
                            
                        }//:VSTACK
                        Spacer()
                        
                    }//:VSTACK
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
                    .opacity($animatingModel.wrappedValue ? 1 : 0)
                    .offset(y: $animatingModel.wrappedValue ? 0 : -100)
                    .animation(Animation.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0))
                    .onAppear {
                        self.animatingModel = true
                    }
                }//:ZSTACK
            }//: Conditional
            
        }//:ZSTACK
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
