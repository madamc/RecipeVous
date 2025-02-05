//
//  MockRecipeRepo.swift
//  RecipeVousTests
//
//  Created by Adam Mitchell on 2/1/25.
//

import Foundation
import RecipeVous

class MockRepo: Repository {
    typealias T = String
    
    var url: URL?
    var urlRequest: URLRequest?
    
    var mockRepoString = "It Passes!"
    
    var mockRepoFailString = "It Failed"
    
    var returnString: Bool = true
    
    func getString(from number: Int) async -> String {
        return await getDataObject() ?? mockRepoFailString
    }
    
    func getDataObject() async -> String? {
        let data = await getData()
        switch (data) {
        case .success(let data):
            return String(data: data, encoding: .utf8)
        case .failure(let error):
            print("Failed to decode string: \(error)")
            return nil
        }
        
    }
    
    func getData() async -> Result<Data, Error> {
        if returnString {
            let data = Data(mockRepoString.utf8)
            return .success(data)
        }
        else {
            print("Failed to get string")
            return .failure(NSError(domain: "TestError", code: 0))
        }
    }
    
}
