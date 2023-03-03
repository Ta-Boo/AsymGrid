//
//  WelcomeRowView.swift
//  AsymGrid
//
//  Created by Tobiáš Hládek on 03/02/2022.
//

import SwiftUI

struct Note: Hashable{
    let image: String?
    let text: String
}

struct WelcomeRowView: View {
    let welcomeText: String
    let notes: [Note]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(welcomeText)
//                .font(.bold(.title2)())
            HStack {
                ForEach(notes, id: \.self) { note  in
                    CapsuleBadge(text: note.text, image: note.image)
                }
                Spacer()
            }
        }
        .padding()
    }
}

struct WelcomeRowView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeRowView(welcomeText: "Good morning, Placeholder", notes: [Note(image: "note", text: "Placeholder"), Note(image: nil, text: "Placeholder1")])
    }
}
