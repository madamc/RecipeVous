//
//  RecipeDetailView.swift
//  RecipeVous
//
//  Created by Adam Mitchell on 1/30/25.
//

import SwiftUI
import WebKit

struct RecipeDetailView: View {
    @ObservedObject var vm: RecipeDetailViewModel
    var body: some View {
        ScrollView {
            VStack {
                Image(uiImage: vm.image ?? UIImage.remove)
                    .containerRelativeFrame(.vertical, count: 5, span: 3, spacing: 0, alignment: .center)
                    .scaledToFit()
                    .clipped()
                Text("Recipe name: \(vm.recipe.name)")
                    .containerRelativeFrame(.vertical, count: 5, span: 1, spacing: 0, alignment: .center)
                Text("Cuisine Type: \(vm.recipe.cuisine)")
                    .containerRelativeFrame(.vertical, count: 5, span: 1, spacing: 0, alignment: .center)
                if let url = vm.youtubeUrl {
                    Text("Youtube Instructions")
                    YoutubeWebView(url: url)
                        .containerRelativeFrame(.vertical, count: 5, span: 2, spacing: 0)
                        .padding()
                        .frame(width: 400.0, height: 400.0, alignment: .top)
                        .clipped()
                }
            }
        }
    }
}

struct YoutubeWebView: UIViewRepresentable {
    var url: URL
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .init(x: 0, y: 0, width: 50.0, height: 50.0))
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    typealias UIViewType = WKWebView
}

#Preview {
    RecipeDetailView(vm: RecipeDetailViewModel(recipe: Recipe(cuisine: "a", name: "b", photo_url_large: "c", photo_url_small: "d", source_url: nil, uuid: "e", youtube_url: nil), service: RecipeService()))
}
