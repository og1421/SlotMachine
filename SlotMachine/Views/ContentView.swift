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
                
                //MARK: - Footer
                
                Spacer()
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
