//
//  WigleModifier.swift
//  AsymGrid
//
//  Created by Tobiáš Hládek on 21/01/2022.
//

import SwiftUI

//TODO: Need to be fixed 
struct WiggleModifier: ViewModifier {
    @State private var isWiggling = false
    
    private static func randomize(interval: TimeInterval, withVariance variance: Double) -> TimeInterval {
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random
    }
    
    private let rotateAnimation = Animation
        .easeInOut(
            duration: WiggleModifier.randomize(
                interval: 0.14,
                withVariance: 0.025
            )
        )
        .repeatForever(autoreverses: true)
    
    private let bounceAnimation = Animation
        .easeInOut(
            duration: WiggleModifier.randomize(
                interval: 0.18,
                withVariance: 0.025
            )
        )
        .repeatForever(autoreverses: true)
    
    private let asd = Animation
        .easeIn(duration: 0.1)
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(isWiggling ? 2.0 : 0), anchor: UnitPoint(x: 0.75, y: 0.5))
            .animation(rotateAnimation)
            .offset(x: 0, y: isWiggling ? 2.0 : 0)
            .animation(bounceAnimation)
            .onAppear() { isWiggling.toggle() }
    }
}

extension View {
    @ViewBuilder
    func wiggling(editMode: Bool) -> some View {
        if editMode  {
            modifier(WiggleModifier())
//            modifier(EmptyModifier())
        } else {
            modifier(EmptyModifier())
        }
    }
}
