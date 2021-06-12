//
//  AsyncImageView.swift
//  SwiftUI3.0
//
//  Created by 岡優志 on 2021/06/12.
//

import SwiftUI

struct AsyncImageView: View {
    let urlImage = URL(string: "https://media.istockphoto.com/vectors/red-apple-illustration-icon-vector-vector-id1045495508?k=6&m=1045495508&s=612x612&w=0&h=d_P7mpubzh6ZBgyrIi9--XT0rYcEdRQX_y-isdmStlQ=")
    var body: some View {
        NavigationView{
            VStack{
                AsyncImage(url: urlImage, scale: 1.0) { image in
                    image.resizable()
                } placeholder: {
                   ProgressView()
                }
                        .frame(width: 240, height: 240)
            }
            .navigationTitle("Async Image")
        }
    }
}
struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView()
    }
}
