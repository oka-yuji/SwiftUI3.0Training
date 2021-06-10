//
//  SearchView.swift
//  SwiftUI3.0
//
//  Created by 岡優志 on 2021/06/10.
//

import SwiftUI

struct SearchView: View {
    let urlString = URL(string: "https://api.github.com/search/repositories?q=swift")
    @State var items = [RepositoryEntity]()
    var body: some View {
        Button(action: {
            guard let url = urlString else {
                return
            }
            let request = URLRequest(url: url)
            print(request)
            
            URLSession.shared.dataTask(with: request) { data, respose, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    guard let decodedResponse = try? decoder.decode(RepositoryResponse.self, from: data) else {
                        print("error")
                        return
                    }
                    DispatchQueue.main.async {
                        items = decodedResponse.items
                        print(items)
                    }
                } else {
                    print("error2")
                }
            }.resume()
        }) {
            Text("Button")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}




struct RepositoryResponse: Codable, Hashable {
    var items: [RepositoryEntity]
}

struct RepositoryEntity: Codable, Hashable {
    var stargazersCount: Int?
    var fullName: String?
    var owner: Owner?
    
    struct Owner: Codable, Hashable {
        var avatarUrl: URL?
    }
}
