//
//  SearchViewModel.swift
//  SwiftUI3.0
//
//  Created by 岡優志 on 2021/06/20.
//
import Foundation

class SearchViewModel: ObservableObject {
    // 疎結合
    private let fetchUser: Fetcher
    init(fetchUser: Fetcher) {
        self.fetchUser = fetchUser
    }
    
    // Viewとのバインディング変数プロパティ
    @Published var itemData: [Item] = []
    @Published var query = ""
    
    func fetcher() {
        let queryText = query
        fetchUser.fetchUserRepository(query: queryText) {(item) in self.itemData.append(contentsOf: item)}
    }
}
