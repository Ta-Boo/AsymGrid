//
//  CardView.swift
//  AsymGrid
//
//  Created by hladek on 09/12/2021.
//

import SwiftUI

enum CardType {
    case small, medium, large, preview
    var size: CGFloat {
        switch self {
        case .preview: return 40
        case .small: return 100
        case .medium: return 140
        case .large: return 180
        }
    }

    var subTitleFont: Font {
        return Font.system(size: size/12)
    }

    var titleFont: Font {
        return Font.system(size: size/10).bold()
    }


    func scale(scaleFactor: CGFloat) -> CGFloat {
        let requiredSize = min(CardType.large.size*scaleFactor, size)
        let result = requiredSize/size
        return result
    }
}

struct StatusCardView: View {
    @Namespace private var StatusCardNamespace
    @Binding var editMode: Bool
    @State var animationAllowed: Bool = false
    @Binding var scaleFactor: CGFloat
    var onDeleteClosure: ((Int) -> Void)
    var cardModel: CardModel

//    init(cardViewModel: CardModel, onDelete: @escaping ((Int) -> Void)) {
    init(cardModel: CardModel, editMode: Binding<Bool>, scale: Binding<CGFloat>, onDelete: @escaping ((Int) -> Void)) {
        self._scaleFactor = scale
        self._editMode = editMode
        self.cardModel = cardModel
        self.onDeleteClosure = onDelete
    }

    var body: some View {
        
        ZStack {
            Circle()
                .stroke(Color.Card.backgroundOutline, style: StrokeStyle(
                    lineWidth: cardModel.type.size * 0.04,
                    lineCap: .square
                ))
                .background(Circle().foregroundColor(.white))
                .frame(
                    width: cardModel.type.size*0.9,
                    height: cardModel.type.size*0.9,
                    alignment: .center
                )

            Circle()
                .trim(from: 1 - cardModel.progress, to: 1)
                .rotation(.degrees(270))
                .stroke(Color.Card.foregroundOutline,
                        style: StrokeStyle(lineWidth: cardModel.type.size * 0.04, lineCap: .square)
                )
                .rotation3DEffect(
                    .degrees(180),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .frame(
                    width: cardModel.type.size*0.9,
                    height: cardModel.type.size*0.9,
                    alignment: .center
                )

            ZStack {

                VStack(alignment: .center, spacing: 0) {
                    Image(cardModel.image)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: cardModel.type.size * 0.42,
                            height: cardModel.type.size * 0.42
                        )
                    Text(cardModel.title)
                        .font(cardModel.type.titleFont)
                        .foregroundColor(.black)
                        .padding(.bottom, 1)
                    Text(cardModel.subtitle)
                        .font(cardModel.type.subTitleFont)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding()
                VStack {
                    Spacer()
                        .frame(height: cardModel.type.size*0.05)
                    HStack {

                        ZStack {
                            if editMode {
                                Text("-")
                                    .font(cardModel.type.titleFont)
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .foregroundColor(.white)
                                    .background(Color.Card.foregroundOutline)
                                    .cornerRadius(50)
                                    .opacity(editMode ? 1 : 0)
                                    .onTapGesture {
                                        withAnimation {
                                            onDeleteClosure(cardModel.index!)
                                        }
                                    }
//                                    .matchedGeometryEffect(id: "CardBadge", in: StatusCardNamespace)
                            } else {
                                Text("New")
                                    .font(cardModel.type.titleFont)
                                    .foregroundColor(.white)
                                    .frame(
                                        width: cardModel.type.size * 0.4,
                                        height: cardModel.type.size * 0.2
                                    )
                                    .background(Color.Card.foregroundOutline.opacity(0.6))
                                    .cornerRadius(50)
                                    .shadow(radius: 2)
                                    .opacity(normalize(actual: scaleFactor, maximum: 1, minimum: 0.35))
//                                    .matchedGeometryEffect(id: "CardBadge", in: StatusCardNamespace)
                            }
                        }
                        Spacer()
                    }
                    Spacer()
                }

            }
            .frame(
                width: cardModel.type.size,
                height: cardModel.type.size,
                alignment: .center
            )


        }
        .shadow(color: Color.black.opacity(0.1), radius: 2)
        .frame(width: cardModel.type.size * scale(), height: cardModel.type.size * scale())
        .scaleEffect(scale())
//        .wiggling(editMode: editMode)
        .onTapGesture {
//            print("x: \(model.x) y: \(model.y)")
            print("------")
        }
    }

    func scale() -> CGFloat {
        return cardModel.type.scale(scaleFactor: scaleFactor)
        //        return scaleFactor
    }
    
    mutating func onDeleteTapped(_ closure: @escaping ((Int) -> Void)) -> some View {
        onDeleteClosure = closure
        return self
    }

    func normalize(actual: CGFloat, maximum: CGFloat, minimum: CGFloat) -> Double{
        let result = (actual - minimum)/(maximum - minimum)
        return Double(result)
    }
}


private struct CardPreview: View {
    @State private var shrinked = false

    var body: some View {
        Text("")
        //        StatusCardView(completedPercentage: 0.65, type: .medium, shrinked: $shrinked)
    }
}


