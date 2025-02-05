//
//  PhotoLargeRepository.swift
//  RecipeVous
//
//  Created by Adam Mitchell on 1/30/25.
//

import Foundation
import UIKit

class PhotoRepository: Repository {
    
    typealias T = UIImage
    
    var url: URL?
    var urlRequest: URLRequest?
    
    func getImage(for url: URL) async -> UIImage? {
        self.url = url
        //This also thre the SIGABRT error : pointer being freed was not allocated
        self.urlRequest = URLRequest(url: url)
        if let image = await getDataObject() {
            return image
        } else {
            print("Failed to create image from data")
            return nil
        }
    }
    
    func getDataObject() async -> UIImage? {
        let result = await getData()
        switch (result) {
        case .success(let data):
            return UIImage(data: data)
        case .failure(let error):
            print("Error retrieving image data: \(error)")
            return nil
        }
    }
    
    func getData() async -> Result<Data, Error> {
        guard let _ = self.url, let urlRequest = self.urlRequest else {
            return .failure(URLError(.badURL))
        }
        // if the url response is cached, return it
        //This threw a failed cast SIGABRT error
        if let response = session.configuration.urlCache?.cachedResponse(for: urlRequest) {
            return .success(response.data)
        }
        // else make a network call
        do {
            return .success(try await session.data(for: urlRequest).0)
        }
        catch {
            return .failure(error)
        }
    }
}
