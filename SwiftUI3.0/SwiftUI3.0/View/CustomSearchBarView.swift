//
//  CustomSearchBarView.swift
//  OnboardViwe
//
//  Created by 岡優志 on 2021/06/13.
//

import SwiftUI

struct CustomSearchBarView: View {
    @EnvironmentObject var searchViewModel: SearchViewModel
    @State var searchText = ""
    private let maxTextLength = 10
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.secondary)
                TextField("input user name", text: $searchText, onCommit: {
                    // enter時に作動
                    searchViewModel.query = ""
                    searchViewModel.query = searchText
                    searchViewModel.fetcher()
//                    searchViewModel.fetchRepository()
                })
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 5)
        .padding(.top, 10)
        // maxTextLengthで指定している文字数までしかTextFieldで打てない処理
        .onChange(of: searchText) { newData in
            if newData.count > maxTextLength {
                searchText.removeLast()
            }
        }
    }
}

struct CustomSearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchBarView()
    }
}
