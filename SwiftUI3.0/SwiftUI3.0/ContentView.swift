//
//  ContentView.swift
//  SwiftUI3.0
//
//  Created by 岡優志 on 2021/06/09.
//

import SwiftUI

struct ContentView: View {
    @State var numText = ""
    var body: some View {
//        GithubAsyncAwait()
        AsyncAwait()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
