//
//  CapsuleBadge.swift
//  AsymGrid
//
//  Created by Tobiáš Hládek on 03/02/2022.
//

import SwiftUI

struct CapsuleBadge: View {
    init(text: String, image: String? = nil) {
        self.text = text
        self.image = image
    }
    
    let text: String
    let image: String?
    var body: some View {
            ZStack {
                HStack{
                    image.map { image in
                        Image(image, label: Text("olaaa"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                    }

                    Text(text)
                        .font(.boldedSubheadline)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.Card.foregroundOutline)
                .mask(Capsule(style: .circular))
            }
    }
}

struct CapsuleBadge_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CapsuleBadge(text: "PlaceHolder",image: "note")
            CapsuleBadge(text: "PlaceHolder")
        }
    }
}
