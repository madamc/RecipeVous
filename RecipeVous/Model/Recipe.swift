//
//  File.swift
//  RecipeVous
//
//  Created by Adam Mitchell on 1/30/25.
//

import Foundation

struct RecipeResult: Hashable, Decodable {
    var recipes: [Recipe]
}

struct Recipe: Hashable, Decodable {
    let cuisine: String
    let name: String
    let photo_url_large: String
    let photo_url_small: String
    let source_url: String?
    let uuid: String
    let youtube_url: String?
}
