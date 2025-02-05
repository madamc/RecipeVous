//
//  File.swift
//  RecipeVous
//
//  Created by Adam Mitchell on 2/3/25.
//

import Foundation
import UIKit

class RecipeRowViewModel: ObservableObject {
    
    var recipe: Recipe
    var imageUrl: URL?
    @Published var image: UIImage?
    var service: RecipeService
    
    init(recipe: Recipe, service: RecipeService) {
        self.recipe = recipe
        self.imageUrl = URL(string: recipe.photo_url_small)
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
