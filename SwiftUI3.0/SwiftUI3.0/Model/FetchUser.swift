//
//  FetchUser.swift
//  SwiftUI3.0
//
//  Created by 岡優志 on 2021/06/20.
//


import Foundation

protocol Fetcher {
    func fetchUserRepository(query: String, completion: @escaping ([Item]) -> Void)
}

class FetchUser: ObservableObject  {
    @Published var searchedRepository: [Item] = []
    @Published var query = ""
    
    // async/await
    func fetchUsers()async {
        let url = URL(string: "https://api.github.com/search/repositories?q=\(query)")
        guard let getURL = url else {
            return print("urlError")
        }
        let session = URLSession(configuration: .default)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do{
            let task = try await session.data(from: getURL)
            let repositories = try decoder.decode(Repositories.self, from: task.0)
            self.searchedRepository.append(contentsOf: repositories.items)
            print(repositories.items[0].language ?? "")
        }
        catch {
            print("error")
        }
    }
    // MVVMに対応したescapingを使用したfetchメソッド
    func fetchUserRepository(query: String, completion: @escaping ([Item]) -> Void) {
        guard let url: URL = URL(string: "https://api.github.com/search/repositories?q=\(query)") else { return print("URL Error") }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let jsonData = data else { return print("Json Error") }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let repositories = try decoder.decode(Repositories.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(repositories.items)
                }
            } catch {
                print("items Decoder Error")
            }
        }
        .resume()
    }
    
    // 素直に書いた形
    func fetcher() {
        // seawrchedRepositoryを最初に空にしておく事で検索せるようにしています
        searchedRepository.removeAll()
        guard let getUrl: URL = URL(string: "https://api.github.com/search/repositories?q=\(query)") else { return }
        // request
        let request = URLRequest(url: getUrl)
        let decoder = JSONDecoder()
        //スネークケースをキャメルケースへ変換してくれる　※全てキャメルケースに書き換える必要がある
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // データを受け取った後の処理
            guard let jsonData = data else { return }
            do {
                let repositories = try decoder.decode(Repositories.self, from: jsonData)
                // 非同期処理
                DispatchQueue.main.async {
                    self.searchedRepository.append(contentsOf: repositories.items)
                }
            } catch {
                print("error1")
            }
        }
        .resume()
    }
}

