//
//  SearchView.swift
//  SwiftUI3.0
//
//  Created by 岡優志 on 2021/06/10.
//

import SwiftUI

struct SearchView: View {
    //    let urlString = URL(string: "https://api.github.com/search/repositories?q=swift")
    @State var a:[User] = []
    @State var b:[String] = ["a", "b", "c"]
    var body: some View {
        VStack{
            Button(action: {
                
                searchGitHubUser(query: "swift")
                
            }) {
                Text("Button")
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


func searchGitHubUser(query: String) {
    //    request作成
    guard let url = URL(string: "https://api.github.com/search/users?q=" + query) else {
        return print("error")
    }
    let request = URLRequest(url: url)
    
    do {
    let apiUrl = url
    let data = try Data(contentsOf: apiUrl)
    let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        print(json)
    } catch {
        print("error")
    }
        
        //    decoder
    let decoder: JSONDecoder = JSONDecoder()
    //    セッションを作る
    let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
        //ここにデータ受信後の処理を書く
        guard let data = data else { return }
        do {
            let user: User = try decoder.decode(User.self, from: data)
//            print(user)
        } catch let e {
            print("JSON Decode Error :\(e)")
        }
        
    }
    task.resume()
    
}




struct User: Codable {
    
    let items: [Item]
    
    struct Item: Codable {
        let login: String
        let avatar_url: URL
        
    }
}
