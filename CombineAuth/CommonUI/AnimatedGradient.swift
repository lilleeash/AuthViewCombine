//
//  AnimatedGradient.swift
//  CombineAuth
//
//  Created by Darya Zhitova on 29.12.2022.
//

import SwiftUI

struct AnimatedGradient: View {
    
    @State private var start = UnitPoint(x: 0, y: 0)
    @State private var end = UnitPoint(x: 0, y: 2)
    
    let colors: [Color]
    
    var body: some View {
        LinearGradient(colors: colors, startPoint: start, endPoint: end)
            .onAppear {
                withAnimation (.easeInOut(duration: 3).repeatForever()) {
                    self.start = UnitPoint(x: 1, y: -1)
                    self.end = UnitPoint(x: 0, y: 1)
                }
            }
    }
}
