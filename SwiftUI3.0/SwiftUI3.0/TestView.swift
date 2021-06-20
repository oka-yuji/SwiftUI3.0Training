//
//  TestView.swift
//  SwiftUI3.0
//
//  Created by 岡優志 on 2021/06/20.
//

import SwiftUI

struct TestView: View {
    @ObservedObject var fetchUser = FetchUser()
    var body: some View {
        NavigationView{
            VStack {
                TextField("input user", text: $fetchUser.query, onCommit: {
                    fetchUser.fetcher()
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List(fetchUser.searchedRepository, id: \.nodeId) { user in
                    Text(user.fullName ?? "")
                }
                .navigationTitle("Repository List")
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
