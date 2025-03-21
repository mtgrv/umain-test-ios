//
//  DataManager.swift
//  UmainMobileTest
//
//  Created by Matteo Gervasi on 21/03/25.
//

import Foundation

@Observable
class DataManager {
    
    var restaurants: [Restaurant] = []
    var isLoading: Bool = false
    
    // MARK: - APIs
    
    private let apiBaseUrl = URL(string: "https://food-delivery.umain.io/api/v1/")!
    
    func fetchData() async {
        
        isLoading = true
        
        let url = apiBaseUrl.appending(component: "restaurants")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            let restaurantResponse = try JSONDecoder().decode(RestaurantsResponse.self, from: data)
            let restaurants = restaurantResponse.restaurants
            
            // Populate filter ids
            let tempFiltersIds = restaurants.map { restaurant in
                restaurant.filterIds
            }.reduce([], +)
            
            // remove duplicates
            let filtersIds = Set(tempFiltersIds)
            
            // get filters data as dictionary with id as keys
            let filtersDictionary = try await fetchFiltersData(for: filtersIds)
            
            //populate filters property for every restaurant
            var restaurantsWithFilters: [Restaurant] = []
            for var restaurant in restaurants {
                restaurant.filters = restaurant.filterIds.compactMap { filtersDictionary[$0] }
                restaurantsWithFilters.append(restaurant)
            }
            
            self.restaurants = restaurantsWithFilters
            isLoading = false
        } catch {
            print(error.localizedDescription)
            isLoading = false
        }
    }
    
    /// fetch filters data and returns them in form of dictionary with id as key
    private func fetchFiltersData(for ids: some Collection<String>) async throws -> [String:Filter] {
        
        try await withThrowingTaskGroup(of: Filter.self, returning: [String:Filter].self) { taskGroup in
            
            for id in ids {
                
                taskGroup.addTask {
                    try await self.fetchFilter(for: id)
                }
            }
            
            var filters = [Filter]()
            
            for try await filter in taskGroup {
                filters.append(filter)
            }
            
            var dict = [String:Filter]()
            for filter in filters {
                dict[filter.id] = filter
            }
            return dict
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
        
    // MARK: API Model
    
    private struct RestaurantsResponse: Decodable {
        
        let restaurants: [Restaurant]
    }
    
    private struct ResponseError: Decodable, Error {

        let error: Bool
        let reason: String
    }
}
