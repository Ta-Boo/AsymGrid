//
//  BubbleViewMOdel.swift
//  AsymGrid
//
//  Created by hladek on 05/01/2022.
//

import Foundation
import SwiftUI

class BubblesViewModel: ObservableObject {
    @Published private(set) var cards = [CardModel]()
    @Published var scaleFactor: CGFloat = 1
    @Published var shrinked = false
    @Published private var debug = "false"
    @Published var editMode: Bool = false
    @Published var secondaryScaleFactor: CGFloat = 1
    @Published var offset: CGFloat
    
    var height: Int
    var ocupationMatrix: [[Bool]]
    let minimalScale: CGFloat = 0.35
    let rowsAboveBubbles: Int = 3
    let rowsCount = 3
    let rowAboveBubblesHeight: CGFloat = 60
    var layout: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 10), count: 3)
    var maxWidth: CGFloat = 0
    var maxHeight: CGFloat = 0
    private var freeCards: [CardModel] = [
        //TODO: Remove when data fetch is available
        CardModel(title: "Medicine", subtitle: "0/3 3", image: "fluid", isNew: true, progress: 0.1, alignment: .center),
        CardModel(title: "Medicine", subtitle: "0/3 1", image: "fluid", isNew: true, progress: 0.1, alignment: .center),
        CardModel(title: "Medicine", subtitle: "0/3 2", image: "fluid", isNew: true, progress: 0.1, alignment: .center),
        CardModel(title: "Medicine", subtitle: "0/3 10", image: "fluid", isNew: true, progress: 0.1, alignment: .center),
        CardModel(title: "Medicine", subtitle: "0/3 6", image: "fluid", isNew: true, progress: 0.1, alignment: .center),
        CardModel(title: "Medicine", subtitle: "0/3 4", image: "fluid", isNew: true, progress: 0.1, alignment: .center),
        CardModel(title: "Medicine", subtitle: "0/3 5", image: "fluid", isNew: true, progress: 0.1, alignment: .center),
        CardModel(title: "Medicine", subtitle: "0/3 8", image: "fluid", isNew: true, progress: 0.1, alignment: .center),
        CardModel(title: "Medicine", subtitle: "0/3 7", image: "fluid", isNew: true, progress: 0.1, alignment: .center),
        CardModel(title: "Medicine", subtitle: "0/3 9", image: "fluid", isNew: true, progress: 0.1, alignment: .center),
        CardModel(title: "Medicine", subtitle: "0/3 11", image: "fluid", isNew: true, progress: 0.1, alignment: .center),
        CardModel(title: "Medicine", subtitle: "0/3 12", image: "fluid", isNew: true, progress: 0.1, alignment: .center),
        CardModel(title: "Medicine", subtitle: "0/3 13", image: "fluid", isNew: true, progress: 0.1, alignment: .center),
    ]

    let bigIndex = 4
    let mediumIndex = 4
    
    init(cards: [CardModel], height: Int = Int(CardType.medium.size + CardType.medium.size)) {
        //TODO: Remove when data fetch is available
        if !cards.isEmpty {
            freeCards = cards
        }
        offset = (CGFloat(rowsAboveBubbles)*rowAboveBubblesHeight + CGFloat(rowsAboveBubbles-1))
        self.height = height
        self.ocupationMatrix = [[Bool]](repeating: [Bool](repeating: false, count: (height/10)), count: Int(CardType.large.size))
        layoutCards()
    }
    
    private func layoutCards() {
        sweepOcupationMatrix()
        var indexer = 0
        var toBeLayout: [CardModel] = freeCards.reversed()
        freeCards.removeAll()
        while !toBeLayout.isEmpty {
            var card = toBeLayout.popLast()!
            placeCard(&card, at: indexer)
            indexer += 1
        }
    }
    
    private func sweepOcupationMatrix() {
        maxHeight = 0
        maxWidth = 0
        for xIndex in 0..<ocupationMatrix.count {
            for yIndex in 0..<ocupationMatrix[xIndex].count {
                ocupationMatrix[xIndex][yIndex] = false
            }
        }
    }
    
    private func placeCard(_ card: inout CardModel, at index: Int) {
        if index <= 4 {
            layoutFirstCardsBlock(card: &card, at: index)
        } else {
            layoutLastCardsBlock(card: &card, at: index)

//            card.setCenterPossition(x: defaultOffset, y: defaultOffset)
        }
    }
    
    private func layoutFirstCardsBlock(card: inout CardModel, at index: Int) {
        let padding: CGFloat = 10
        let defaultXOffset = CardType.small.size * 0.5
        let defaultYOffset = CardType.small.size * 0.8
        let centralShift = CardType.small.size / 2
        let row: CGFloat = CGFloat(index % rowsCount)
        
        switch index {
        case 3 :
            card.type = .large
            card.setCenterPossition(x: CardType.large.size * 0.5 + 2 * padding + CardType.small.size ,
                                    y: CardType.large.size * 0.5)
        case 4 :
            card.type = .medium
            card.setCenterPossition(x: CardType.large.size * 0.5 + 2 * padding + CardType.small.size,
                                    y: CardType.large.size + CardType.medium.size * 0.5 + padding)
        case 1 :
            card.type = .small
            card.setCenterPossition(x: defaultXOffset + centralShift, y: defaultYOffset + row * CardType.small.size + row * padding )
        default:
            card.type = .small
            card.setCenterPossition(x: defaultXOffset, y: defaultYOffset + row * CardType.small.size + row * padding )
        }
        card.index = index
        cards.append(card)
    }
    
    private func layoutLastCardsBlock(card: inout CardModel, at index: Int) {
        let padding: CGFloat = 10
        let defaultYOffset = CardType.small.size * 0.8
        let row = (index-5) % rowsCount
        let column = CGFloat((index-5)/rowsCount)
        
        let firstBlockOffset = CardType.large.size + 4 * padding + CardType.small.size
        let shift = row == 1 ? CardType.small.size * 0.5 : 0

        
        card.type = .small
        let xPossition = firstBlockOffset + CardType.small.size*0.5 - shift + CardType.small.size * column + padding * column
        let yPossition = defaultYOffset + (CardType.small.size * CGFloat(row)) + (padding * CGFloat(row))
        card.setCenterPossition(x: xPossition,
                                y: yPossition
        )
        let actualWidth = xPossition + CardType.small.size / 2
        let actualHeight = yPossition + CardType.small.size / 2
        maxWidth = actualWidth > maxWidth ? actualWidth : maxWidth
        maxHeight = actualHeight > maxHeight ? actualHeight : maxHeight
        print(maxWidth)
        card.index = index
        cards.append(card)
        
        
    }
    
    private func placeCardOutdated(_ card: inout CardModel, at index: Int) {
        parentLoop: for xIndex in 0..<ocupationMatrix.count {
            for yIndex in 0..<ocupationMatrix[xIndex].count {
                let occupied = ocupationMatrix[xIndex][yIndex]
                let size = Int(card.type.size)/10
                let randomOffset = Int(arc4random_uniform(20))
                if !occupied {
                    if yIndex + size + randomOffset/10 <= ocupationMatrix[0].count  {
                        var emptyEstimate = true
                        emptyCheck: for width in xIndex ..< xIndex+size {
                            for height in yIndex ..< yIndex+size {
                                if ocupationMatrix[width][height] {
                                    emptyEstimate = false
                                    break emptyCheck
                                }
                            }
                        }
                        if emptyEstimate {
                            for width in xIndex ..< xIndex+size {
                                for height in yIndex ..< yIndex+size+randomOffset/10 {
                                    ocupationMatrix[width][height] = true
                                }
                            }
                            card.setPossition(x: CGFloat(xIndex)*10, y: CGFloat(yIndex*10+randomOffset))
                            card.index = index
                            cards.append(card)
                            let actualWidth = CGFloat((xIndex + size)*10)
                            let actualHeight = CGFloat((yIndex + size)*10 + randomOffset)
                            maxWidth = actualWidth > maxWidth ? actualWidth : maxWidth
                            maxHeight = actualHeight > maxHeight ? actualHeight : maxHeight
                            break parentLoop
                        }
                    }
                }
            }
        }
    }
    
    func deleteCard(at index: Int) {
        cards.removeAll(where: {index == $0.index})
        freeCards = cards
        cards.removeAll()
        withAnimation {
            layoutCards()
        }
    }
    
    
    func computeScaleFactor(minY: CGFloat) {
        let result = scale(minY: minY)
        if result > 1 {
            scaleFactor = 1
        } else if result <= minimalScale {
            scaleFactor = minimalScale
        }
        scaleFactor = min(1, result)
    }
    
    func scale(minY: CGFloat) -> CGFloat {
        let maxPossition: CGFloat = 180
        let minPossition: CGFloat = 40 // space between min and max affect scaling speed
        var result = (minY - minPossition)/(maxPossition - minPossition)
        result = max(0, result)
        secondaryScaleFactor = min(result, 1)
        //        result = log(result)/2+1
        
        if result > 1 {
            return 1
        }
        else if result < minimalScale {
            return minimalScale
        }
        return result
    }
    
    func scalize(scale: CGFloat, maximum: CGFloat, minimum: CGFloat) -> CGFloat{
        guard minimum <= maximum else {
            return 0
        }
        let range = maximum - minimum
        let value = scale * range
        let result = minimum + value
        return result
    }

    func scalize(scale: CGFloat, from: CGFloat, to: CGFloat) -> CGFloat{
        let distance = from - to
        let result = -1*(distance * (1-scale)) + from
        return result
    }
    
}
