//
//  RecipeService.swift
//  RecipeVous
//
//  Created by Adam Mitchell on 1/30/25.
//

import Foundation
import UIKit

protocol Service {
    
}

class RecipeService: Service {
    
    private var recipeRepo = RecipeRepository()
    private var photoRepo = PhotoRepository()

    func getRecipes(for url: URL) async -> [Recipe] {
        return await recipeRepo.getRecipes(with: url)
    }
    
    func getImage(for url: URL) async -> UIImage? {
        return await photoRepo.getImage(for: url)
    }
    
}
