//
//  MarkDownTextTraining.swift
//  SwiftUI3.0
//
//  Created by 岡優志 on 2021/06/12.
//

import SwiftUI

struct MarkDownTextTraining: View {
    var body: some View {
        VStack{
            Text("Greeting *hello*")
            Text("Greeting **hello**")
            Text("Greeting ***hello***")
            Text("Greeting ~~hello~~")
            Text("Greeting `hello`")
            Text("[apple](https://apple.com)")
        }
    }
}

struct MarkDownTextTraining_Previews: PreviewProvider {
    static var previews: some View {
        MarkDownTextTraining()
    }
}
