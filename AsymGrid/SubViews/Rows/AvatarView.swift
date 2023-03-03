//
//  SwiftUIView.swift
//  AsymGrid
//
//  Created by Tobiáš Hládek on 03/02/2022.
//

import SwiftUI

struct AvatarView: View {
    let image: String
    let text: String
    var body: some View {
        ZStack(alignment: .leading) {
            let capsuleOffset = CGSize(width: 30, height: 0)
            let imageCircleSize: CGFloat = 48
            let imageSize: CGFloat = 37
            let imageOffset = (imageCircleSize - imageSize)/2
                Circle()
                   .foregroundColor(Color.Avatar)
                   .frame(width: imageCircleSize, height: imageCircleSize)
                Capsule(style: .circular)
                    .frame(width: 113, height: 28)
                    .foregroundColor(Color.Avatar)
                    .offset(capsuleOffset)
                Text(text)
                    .offset(capsuleOffset)
                    .padding(.leading, 15)
                    .frame(width: 105, height: 20)
                    .foregroundColor(Color.white)
                    .font(.boldedSubheadline)
                Image(image, label: Text("asdads"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .mask(Circle())
                    .frame(width: imageSize, height: imageSize)
                    .offset(CGSize(width: imageOffset, height: 0))
            }
        .padding(.horizontal, 10)
            
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            AvatarView(image: "avatar", text:"Placeholder")
            AvatarView(image: "avatar", text:"Placeholder")

        }
    }
}
