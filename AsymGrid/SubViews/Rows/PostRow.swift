//
//  PostRow.swift
//  AsymGrid
//
//  Created by Tobiáš Hládek on 03/02/2022.
//

import SwiftUI

struct PostRow: View {
    let avatarImage: String?
    let posterName: String
    let date: String
    let postText: String
    let commentsCount: String
    
    var body: some View {
        HStack(alignment: .top, spacing : 0) {
            if avatarImage != nil {
                Image(avatarImage!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 37, height: 37)
                    .mask(Circle())
                    .overlay(Circle().stroke(Color.Card.backgroundOutline, lineWidth: 4))
            } else {
                // TODO:
            }
            VStack(alignment: .leading) {
                Text(posterName)
//                    .font(.bold(.title2)())
                Text(date)
                Spacer()
                    .frame(height: 8)
                Text(postText)
                HStack(alignment: .center) {
                    Image("like_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                    Spacer().frame(width: 10)
                    Text("Like")
                    Spacer().frame(width: 24)
                    Image("chat_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                    Spacer().frame(width: 10)
                    Text(commentsCount)
                    
                }
            }
            .padding(.horizontal)
        }
        .padding()
        
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(avatarImage: "avatar", posterName: "PosterPlaceHolder", date: "DatePlaceHolder", postText: "PostPlaceholder", commentsCount: "placeHolder")
    }
}
