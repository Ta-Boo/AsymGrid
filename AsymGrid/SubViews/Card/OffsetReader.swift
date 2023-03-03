//
//  OffsetReader.swift
//  AsymGrid
//
//  Created by Tobiáš Hládek on 03/02/2022.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
