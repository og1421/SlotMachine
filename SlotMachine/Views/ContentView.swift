//
//  ContentView.swift
//  SlotMachine
//
//  Created by Orlando Moraes Martins on 07/03/23.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Properties
    
    
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
                        
                        Text("100")
                            .scoredNumberStyle()
                            .modifier(ScoredNumberModifier())
                    }//:HSTACK
                    .modifier(ScoreContainerModifier())
                    
                    
                    Spacer()
                    
                    HStack{
                        Text("200")
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
                        
                        Image("gfx-bell")
                            .resizable()
                            .modifier(ImageModifier())
                    }//:ZSTACK
                    
                    HStack{
                        //MARK: - Reel 2
                        ZStack {
                            ReelView()
                            
                            Image("gfx-cherry")
                                .resizable()
                                .modifier(ImageModifier())
                        }//:ZSTACK
                        
                        Spacer()
                        
                        //MARK: - Reel 3
                        ZStack {
                            ReelView()
                            
                            Image("gfx-seven")
                                .resizable()
                                .modifier(ImageModifier())
                        }//:ZSTACK
                    }
                    .frame(maxWidth: 500)
                    
                    //MARK: - SpinButton
                    Button {
                        print("Spin the wheels")
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
                            print("Bet 20 coins")
                        } label: {
                            Text( "20")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .modifier(BetNumberModifier())
                            
                        }//: BUtton
                        .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(0)
                            .modifier(CasinoChipsModifier())
                    }//:HStack
                    
                    //MARK: - Bet 10
                    HStack(alignment: .center, spacing: 10) {
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(1)
                            .modifier(CasinoChipsModifier())
                        
                        Button {
                            print("Bet 10 coins")
                        } label: {
                            Text( "10")
                                .fontWeight(.heavy)
                                .foregroundColor(.yellow)
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
                    print("info view")
                } label: {
                    Image(systemName: "info.circle")
                }
                    .modifier(ButtonModifier()),
                    alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
            
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
