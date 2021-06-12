//
//  AsyncAwait.swift
//  SwiftUI3.0
//
//  Created by 岡優志 on 2021/06/12.
//

import SwiftUI

struct AsyncAwait: View {
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")
    @State var items: [Item] = []
    @State var searchText = ""
    @State var asyncText = ""
    var body: some View {
        NavigationView {
            List{
            Text(asyncText)
            }
//            List {
//                ForEach(items) { item in
//                    VStack(alignment: .leading) {
//                        Text(item.username)
//                        Text(item.name)
//                            .font(.caption)
//                        //                    AsyncImage(url: user.avatarUrl)
//                    }
//                    .listRowSeparatorTint(.red)
//                }
//
//            }
//            .refreshable (action: {
//                await fetchUsers()
//            })
//            .searchable("検索したい名前を入力して下さい", text: $searchText, suggestions: {
//                ForEach(items.filter{ user in
//                    searchText == "" ? true : user.name.lowercased().contains(searchText.lowercased())
//                }) { user in
//                    Text(user.name)
//                }
//            })
            .navigationTitle("Refreshable")
            .refreshable {
                
                asyncText = await task1()
            }
        }
//    }
//    func fetchUsers()async {
//        guard let getURL = url else {
//            return print("urlError")
//        }
//        let session = URLSession(configuration: .default)
//        do{
//            let task = try await session.data(from: getURL)
//            let users = try JSONDecoder().decode([Item].self, from: task.0)
//            self.items = users
//        }
//        catch {
//            print("error")
//        }
    }
}

struct AsyncAwait_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwait()
    }
}

struct Item: Identifiable, Codable {
    var id: Int
    var name: String
    var username: String
}


func task1()async -> String {
    let text = "async success"
    return text
}
