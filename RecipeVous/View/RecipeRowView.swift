//
//  RecipeRowView.swift
//  RecipeVous
//
//  Created by Adam Mitchell on 1/30/25.
//

import SwiftUI

struct RecipeRowView: View {
    @ObservedObject var vm: RecipeRowViewModel
//    let viewModel: RecipeRowView
    
    var body: some View {
        VStack {
            HStack {
                Text(vm.recipe.name)
                Spacer()
                Spacer()
                Image(uiImage: vm.image ?? UIImage.remove)
                    .frame(maxWidth: 50, maxHeight: 50)
                    .padding()
                    .clipped()
                    .cornerRadius(CGFloat(10))
                    .scaledToFit()
            }
            Divider()
        }
    }
}

#Preview {
    RecipeRowView(vm: RecipeRowViewModel(recipe: Recipe(cuisine: "a", name: "b", photo_url_large: "c", photo_url_small: "d", source_url: nil, uuid: "e", youtube_url: nil), service: RecipeService()))
}

struct SmallImageWrapper: View {
    let image: UIImage?
    var body: some View {
        Image(uiImage: image ?? UIImage.remove)
            .frame(width: 15, height: 15)
            .padding()
            .scaledToFit()
    }
}
