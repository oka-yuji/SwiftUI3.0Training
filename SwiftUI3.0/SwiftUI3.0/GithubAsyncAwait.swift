//
//  GithubAsyncAwait.swift
//  SwiftUI3.0
//
//  Created by 岡優志 on 2021/06/12.
//

import SwiftUI

struct GithubAsyncAwait: View {
    @State var successText = ""
    var body: some View {
        NavigationView {
            List {
                Text(successText)
                Text(successText)
                Text(successText)
                Text(successText)
                Text(successText)
            }
           
            .refreshable {
                successText = "success"
            }
            .navigationTitle("Async/Await")
        }
    }
}


struct GithubAsyncAwait_Previews: PreviewProvider {
    static var previews: some View {
        GithubAsyncAwait()
    }
}
