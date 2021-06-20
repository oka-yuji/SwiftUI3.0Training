//
//  UserRipositoryView.swift
//  OnboardViwe
//
//  Created by 岡優志 on 2021/06/13.
//

import SwiftUI

struct UserRipositoryView: View {
    @State var image: UIImage?
    let fetchFullName: String
    let fetchLanguageText: String
    let fetchStarsText: String
    let fetchWatchText: String
    let fetchForksText: String
    let fetchIssuesText: String
    let fetchAvatarURL: String
    var body: some View {
        VStack{
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .clipShape(Circle())
            }
            VStack(spacing: 10.0) {
                Text(fetchFullName)
                    .font(.title)
                VStack(alignment: .trailing, spacing: 10.0){
                    HStack{
                        Text("Written in / \(fetchLanguageText)")
                        Spacer()
                        Text("Stars / \(fetchStarsText)")
                    }
                    Text("Watch / \(fetchWatchText)")
                    Text("Forks / \(fetchForksText)")
                    Text("Issues / \(fetchIssuesText)")
                }
            }
            .padding()
            Spacer()
        }
// image
        .onAppear {
            guard let url = URL(string: fetchAvatarURL) else { return }
            downloadImageAsync(url: url) { image in
                self.image = image
            }
        }
    }
}

struct UserRipositoryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UserRipositoryView(fetchFullName: "Title", fetchLanguageText: "Language", fetchStarsText: "stars", fetchWatchText: "watch", fetchForksText: "forks", fetchIssuesText: "issues", fetchAvatarURL: "https://illustimage.com/photo/6845.png")
        }
    }
}


func downloadImageAsync(url: URL, completion: @escaping (UIImage?) -> Void) {
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { (data, _, _) in
        var image: UIImage?
        if let imageData = data {
            image = UIImage(data: imageData)
        }
        DispatchQueue.main.async {
            completion(image)
        }
    }
    task.resume()
}
