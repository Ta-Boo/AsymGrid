//
//  TabBarView.swift
//  AsymGrid
//
//  Created by Tobiáš Hládek on 19/01/2022.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: BubblesViewModel(cards: [],height: Int(CardType.medium.size + CardType.large.size)))
                .tabItem{
                    Text("Large + medium")
                }
            HomeView(viewModel: BubblesViewModel(cards: [],height: Int(CardType.medium.size + CardType.medium.size)))
                .tabItem{
                    Text("medium + medium")
                }
            HomeView(viewModel: BubblesViewModel(cards: [],height: Int(CardType.small.size + CardType.medium.size)))
                .tabItem{
                    Text("Large + small")
                }
            HomeView(viewModel: BubblesViewModel(cards: [],height: Int(CardType.large.size + CardType.large.size)))
                .tabItem{
                    Text("Large + Large")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
