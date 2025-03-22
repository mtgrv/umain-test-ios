//
//  APIManager.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 22/03/25.
//

import Foundation

class APIManager {
    
    private let apiBaseUrl: URL
    
    init(baseUrl: String = "https://food-delivery.umain.io/api/v1/") {
        self.apiBaseUrl = URL(string: baseUrl)!
    }
    
    func fetchRestaurants() async throws -> [Restaurant] {
                
        let url = apiBaseUrl.appending(component: "restaurants")
        
        let (data, response) = try await URLSession.shared.data(from: url)
            
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            
            let error = try JSONDecoder().decode(ResponseError.self, from: data)
            throw error
        }
            
        let restaurantResponse = try JSONDecoder().decode(RestaurantsResponse.self, from: data)
        return restaurantResponse.restaurants        
    }
    
    func fetchFilters(for ids: some Collection<String>) async throws -> [Filter] {
        
        try await withThrowingTaskGroup(of: Filter.self, returning: [Filter].self) { taskGroup in
            
            for id in ids {
                
                taskGroup.addTask {
                    try await self.fetchFilter(for: id)
                }
            }
            
            var filters = [Filter]()
            
            for try await filter in taskGroup {
                filters.append(filter)
            }
            return filters
        }
    }
    
    private func fetchFilter(for id: String) async throws -> Filter {
        
        let url = apiBaseUrl.appending(component: "filter/\(id)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            
            let error = try JSONDecoder().decode(ResponseError.self, from: data)
            throw error
        }
        
        return try JSONDecoder().decode(Filter.self, from: data)
    }
    
    // MARK: Model
    
    private struct RestaurantsResponse: Decodable {
        
        let restaurants: [Restaurant]
    }
    
    private struct ResponseError: Decodable, Error {

        let error: Bool
        let reason: String
    }
}
