//
//  PostsView.swift
//  AsymGrid
//
//  Created by Tobiáš Hládek on 15/02/2022.
//

import SwiftUI
struct PostModel: Identifiable {
    let id = UUID()
    
}

struct FilterModel: Hashable {
    let tag: String
}

class PostsViewModel: ObservableObject {
    @Published var posts: [PostModel]
    var filters: [FilterModel] = [
        FilterModel(tag: "All"),
        FilterModel(tag: "Kidney"),
        FilterModel(tag: "Heart"),
        FilterModel(tag: "Lung"),
    ]
    init(posts: [PostModel]) {
        self.posts = posts
    }
}

struct FilterBadge: View {
    init(tag: String) {
        self.tag = tag
    }
    let tag: String
    var body: some View {
        Text(tag)
            .font(.boldedSubheadline)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.Card.foregroundOutline)
            .mask(Capsule(style: .circular))
    }
}

//struct FilterBadgesView: View {
//    var body: some View {
//
//    }
//}

struct PostsView: View {
    @ObservedObject var viewModel: PostsViewModel
    @State private var colorScheme = 1

    var body: some View {
        HStack {
//            ForEach(viewModel.filters, id: \.self) { filter in
//                FilterBadge(tag: filter.tag)
//            }
            Picker("Color Scheme", selection: $colorScheme) {
                Text("Light").tag(0)
                Text("Dark").tag(1)
            }
            .pickerStyle(.segmented)
            .foregroundColor(.red)


        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView(viewModel: PostsViewModel(posts: []))
    }
}
