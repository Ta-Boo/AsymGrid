//
//  CardViewModel.swift
//  AsymGrid
//
//  Created by Tobiáš Hládek on 03/02/2022.
//

import Foundation
import SwiftUI

struct CardModel: Identifiable, Equatable {
    static func == (lhs: CardModel, rhs: CardModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var title: String
    var subtitle: String
    var image: String
    var isNew: Bool
    var progress: CGFloat
    var type: CardType = .small
    var alignment: CardAlignment
    
    var x: CGFloat?
    var y: CGFloat?
    var index: Int?

    mutating func setPossition(x: CGFloat, y: CGFloat) {
        self.x = x
        self.y = y
    }
    
    mutating func setCenterPossition(x: CGFloat, y: CGFloat) {
        let offset = type.size * 0.5
        setPossition(x: x - offset, y: y - offset)
    }
}

enum CardAlignment {
    case top, bot, center
}
