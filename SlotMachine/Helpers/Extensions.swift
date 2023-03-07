//
//  Extensions.swift
//  SlotMachine
//
//  Created by Orlando Moraes Martins on 07/03/23.
//

import SwiftUI

extension Text {
    func scoreLabelStyle() -> Text {
        self
            .foregroundColor(.white)
            .font((.system(size: 10, weight: .bold, design: .rounded)))
    }
    
    func scoredNumberStyle() -> Text {
        self
            .foregroundColor(.white)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
    }
}
