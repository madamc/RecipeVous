//
//  Repository.swift
//  RecipeVous
//
//  Created by Adam Mitchell on 1/31/25.
//
import Foundation

protocol Repository<T> {
    associatedtype T
    
    var url: URL? { get set }
    var urlRequest: URLRequest? { get set }
    
    func getDataObject() async -> T?
    
    func getData() async -> Result<Data, Error>
}

extension Repository {
    var decoder: JSONDecoder {
        return JSONDecoder()
    }
    var session: URLSession {
        URLSession.shared
    }
    

}
