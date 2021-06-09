//
//  AnysncAwait.swift
//  SwiftUI3.0
//
//  Created by 岡優志 on 2021/06/09.
//

import SwiftUI

struct AnysncAwait: View {
    //    let url = URL(string: "https://api.github.com/search/repositories?q=swift")!
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        @State var items: [Item] = []
        @State var searchText = ""
        var body: some View {
            NavigationView {
                List {
                    ForEach(items) { item in
                        VStack(alignment: .leading) {
                            Text(item.username)
                            Text(item.name)
                                .font(.caption)
        //                    AsyncImage(url: user.avatarUrl)
                        }
                        .listRowSeparatorTint(.red)
                    }
                    
                }
                .refreshable (action: {
                    await fetchUsers()
                })
                .searchable("検索したい名前を入力して下さい", text: $searchText, suggestions: {
                    ForEach(items.filter{ user in
                        searchText == "" ? true : user.name.lowercased().contains(searchText.lowercased())
                    }) { user in
                    Text(user.name)
                    }
                })
                .navigationTitle("Indicator")
            }
        }
        func fetchUsers()async {
            let session = URLSession(configuration: .default)
            do{
                let task = try await session.data(from: url)
                let users = try JSONDecoder().decode([Item].self, from: task.0)
                self.items = users
            }
            catch {
                print("error")
            }
        }
}

struct AnysncAwait_Previews: PreviewProvider {
    static var previews: some View {
        AnysncAwait()
    }
}

struct Item: Identifiable, Codable {
    var id: Int
    var name: String
    var username: String
//    var avatarUrl: URL
}

