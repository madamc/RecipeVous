//
//  RecipeDetailViewModel.swift
//  RecipeVous
//
//  Created by Adam Mitchell on 1/30/25.
//

import Foundation
import Combine
import UIKit

class RecipeDetailViewModel: ObservableObject {
    
    var recipe: Recipe
    var imageUrl: URL?
    @Published var image: UIImage?
    var service: RecipeService
    var youtubeUrl: URL?
    
    init(recipe: Recipe, service: RecipeService) {
        self.recipe = recipe
        self.imageUrl = URL(string: recipe.photo_url_large)
        if let urlString = recipe.youtube_url {
            self.youtubeUrl = URL(string: urlString)
        }
        self.service = service
        Task { [weak self] in
            await self?.loadRecipeImage()
        }
    }
    
    func loadRecipeImage() async {
        guard let iUrl = imageUrl else {
            return
        }
        if let image = await service.getImage(for: iUrl) {
            DispatchQueue.main.async {
                self.image = image
            }
        }
        else if self.image == nil {
            DispatchQueue.main.async {
                self.image = UIImage(systemName: "document")
            }
        }
        
    }
    
}
