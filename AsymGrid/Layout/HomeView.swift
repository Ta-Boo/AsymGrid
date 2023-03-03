//
//  UsingOffsetsView.swift
//  AsymGrid
//
//  Created by hladek on 21/12/2021.
//

import SwiftUI


struct HomeView: View {
    @ObservedObject private var viewModel: BubblesViewModel
    
    init(viewModel: BubblesViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(UIColor.white)
            
            ScrollView(showsIndicators: false) {

                CompatibleVStack(alignment: .leading ,spacing: 10) {
                    AvatarView(image: "avatar", text:"Placeholder")
                    Divider()
                    WelcomeRowView(welcomeText: "Good morning, Placeholder", notes: [Note(image: "note", text: "Placeholder"), Note(image: nil, text: "Placeholder1")])
                    Divider()
                    
                    Text("TODO : Custom progress bar")
                        .frame(height: viewModel.rowAboveBubblesHeight)
                    Divider()
                        .background(
                            GeometryReader {
                                ///Scroll offset watcher
                                Color.clear.preference(key: ViewOffsetKey.self, value: $0.frame(in: .global).minY)
                            }
                        )
                        .onPreferenceChange(ViewOffsetKey.self) { value in viewModel.computeScaleFactor(minY: value) }
                    
                    Section(header: BubblesView(viewModel: _viewModel)) {
                        ///Container bellow bubbles
                        ForEach((1...20), id: \.self) { data in
                            PostRow(avatarImage: "avatar", posterName: "PosterPlaceHolder", date: "DatePlaceHolder", postText: "PostPlaceholder", commentsCount: "placeHolder")
                        }
                    }
                }
            }
        }
    }
}


struct CompatibleVStack<Content> : View where Content : View {
    let alignment: HorizontalAlignment
    let spacing: CGFloat?
    let content: () -> Content

    init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil,
            @ViewBuilder content: @escaping () -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
      Group {
        if #available(iOS 14, *) { // << add more platforms if needed
            LazyVStack(alignment: alignment, spacing: spacing, pinnedViews: [.sectionHeaders], content:content)
        } else {
            VStack(alignment: alignment, spacing: spacing, content:content)
        }
      }
    }
}

