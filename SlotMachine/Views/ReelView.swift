//
//  ReelView.swift
//  SlotMachine
//
//  Created by Orlando Moraes Martins on 08/03/23.
//

import SwiftUI

struct ReelView: View {
    //MARK: - Properties
    
    //MARK: - Body
    var body: some View {
        Image("gfx-reel")
            .resizable()
            .modifier(ImageModifier())
    }
}

//MARK: - Preview
struct ReelView_Previews: PreviewProvider {
    static var previews: some View {
        ReelView()
            .previewLayout(.fixed(width: 220, height: 220))
    }
}
