//
//  BubblesView.swift
//  AsymGrid
//
//  Created by Tobiáš Hládek on 09/02/2022.
//

import SwiftUI

struct BubblesView : View {
    @ObservedObject private var viewModel: BubblesViewModel
    
    init(viewModel: ObservedObject<BubblesViewModel>) {
        self._viewModel = viewModel
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                VStack{
                    ZStack(alignment: .center) {
                        ForEach(viewModel.cards) { card in
                            let deleteAction: (Int) -> Void = { index in
                                withAnimation {
                                    viewModel.deleteCard(at: index)
                                }
                            }
                            StatusCardView(cardModel: card,
                                           editMode: $viewModel.editMode,
                                           scale: $viewModel.scaleFactor,
                                           onDelete: deleteAction)
                                .position(
                                    x: viewModel.scalize(scale: viewModel.secondaryScaleFactor,
                                               from: card.x! + card.type.size*0.5,
                                               to: CGFloat(CardType.preview.size * CGFloat(card.index!) + 20 )*1.5 - CardType.preview.size*0.2),
                                    y: viewModel.scalize(scale: viewModel.secondaryScaleFactor,
                                               maximum: max(card.y! + card.type.size*0.5, CardType.preview.size),
                                               minimum: min(card.y! + card.type.size*0.5, CardType.preview.size)
                                              )
                                )
                                .onLongPressGesture{
                                    withAnimation{
                                        viewModel.editMode.toggle()
                                    }
                                }
//                                .modifier(WiggleModifier())
                        }
                    }
                    .animation(.easeInOut, value: viewModel.cards)
                    .frame(width: 1, height: 1)
                    Spacer()
                }
                Spacer()
            }
            .frame(width: CGFloat(viewModel.maxWidth), height:  viewModel.scalize(scale: viewModel.secondaryScaleFactor, maximum: (CGFloat(viewModel.maxHeight)), minimum: CardType.preview.size*2))
            .padding(.horizontal)
        }
    }
}
