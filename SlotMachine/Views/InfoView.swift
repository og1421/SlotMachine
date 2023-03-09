//
//  InfoView.swift
//  SlotMachine
//
//  Created by Orlando Moraes Martins on 09/03/23.
//

import SwiftUI

struct InfoView: View {
    //MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LogoView()
            
            Spacer()
            
            Form{
                Section(header: Text("About the application")){
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Platforms", secondItem: "iPhone, iPad, Mac")
                    FormRowView(firstItem: "Developer", secondItem: "Orlando Moraes Martins")
                    FormRowView(firstItem: "Designer", secondItem: "Robert Petras")
                    FormRowView(firstItem: "Music", secondItem: "Dan Lebowitz")
                    FormRowView(firstItem: "Website", secondItem: "swiftuimasterclass.com")
                    FormRowView(firstItem: "Copyright", secondItem: "2023 All rights reserved")
                    FormRowView(firstItem: "Version", secondItem: "1.0.0")
                    
                }//:Section
            }//:FORM
            .font(.system(.body, design: .rounded))
        }//:VSTACK
        .padding(.top, 40)
        .overlay(
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
            }
                .padding(.top, 30)
                .padding(.trailing, 20)
                .accentColor(Color.secondary)
            ,
            alignment: .topTrailing
        )
    }
}

//MARK: - Preview
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

struct FormRowView: View {
    //MARK: - Properties
    var firstItem: String
    var secondItem:String
    
    //MARK: - Body
    var body: some View {
        HStack{
            Text(firstItem)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(secondItem)
                
        }
    }
}
