//
//  SearchView.swift
//  SwiftUI3.0
//
//  Created by 岡優志 on 2021/06/20.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var searchViewModel: SearchViewModel
    var body: some View {
        NavigationView {
            VStack(spacing: 0.0){
                CustomSearchBarView()
                List(searchViewModel.itemData, id: \.nodeId) { item in
                    NavigationLink (
                        destination: UserRipositoryView(fetchFullName: item.fullName ?? "", fetchLanguageText: item.language ?? "", fetchStarsText: "\(item.stargazersCount ?? 0)", fetchWatchText: "\(item.watchersCount ?? 0)", fetchForksText: "\(item.forksCount ?? 0)", fetchIssuesText: "\(item.openIssuesCount ?? 0)", fetchAvatarURL: item.owner.avatarUrl ?? "")
                            .ignoresSafeArea(edges: .bottom))
                    {
                        Text(item.fullName ?? "")
                    }
                }
                .navigationTitle("GitHub")
                .navigationBarTitleDisplayMode(.inline)
            }
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(SearchViewModel(fetchUser: FetchUser() as! Fetcher))
    }
}


