//
//  RemoteImage.swift
//  DogWallpaper
//
//  Created by Azim Talukdar on 01/03/24.
//

import SwiftUI

struct RemoteImage: View {
    private let url: URL
    @State private var imageData: Data?
    
    init(url: URL) {
        self.url = url
    }
    
    var body: some View {
        Group{
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Image(systemName: "photo")
                    .resizable()
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                imageData = data
            }
        }.resume()
    }
}

#Preview {
    RemoteImage(url: URL(string: "https://images.dog.ceo/breeds/terrier-lakeland/n02095570_889.jpg")!)
}
